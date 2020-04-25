require "platforms/core"

module Platforms
  module Yammer
    # A module for Controllers to include so that the OAuth2 flow
    # can be correctly captured from OmniAuth.
    #
    # The {#save_identity} method will set instance variables in the Controller
    # for:
    # * @token, which should be saved in the session for making
    #   subsequent API requests.
    # * @platforms_user, which identifies the authenticated {Platforms::User}
    # * @platforms_network, the {Platforms::Network} that the authenticated
    #   user belongs to
    # * @switch_network_ids, an Array of {Platforms::Network} ids that the
    #   user can switch to (subject to API permissions).
    #
    # @example Include in a controller
    #   # app/controllers/my_controller.rb
    #
    #   class MyController < ApplcationController
    #     include Platforms::Yammer::Authentication
    #
    #     before_action :set_token
    #
    #     ...
    #
    #     def accept
    #       save_identity
    #       ...
    #     end
    #
    #   end
    #
    # @author Benjamin Elias
    # @since 0.1.0
    module Authentication
      extend ActiveSupport::Concern

      include Platforms::Core::OAuth2

      included do
        # The token to use for {Client} requests
        attr_reader :token

        # The Platforms::Network of the authenticated user
        attr_reader :platforms_network

        # The Platforms::User of the authenticated user
        attr_reader :platforms_user

        # Possible Platforms::Network to switch to (useful later)
        attr_reader :switch_network_ids
      end

      # Set the token within the class
      #
      # A convenience method, as the token is available in request.env
      # @return [String] the token from OmniAuth
      def set_token
        @token ||= request.env["omniauth.auth"].credentials.token
      end

      # The Faraday-based client to make REST requests
      #
      # This is required for {#save_identity} to get additional information
      # about the network context.
      # @return [Platforms::Yammer::Client] the client able to be used
      def client
        @client ||= Client.new @token
      end

      # Save the current identity
      #
      # Note that OmniAuth::Yammer effectively delivers /users/current.json
      # as the extra.raw_info. Rather than delivering the original
      # /oauth2/access_token response. Therefore we need to make another
      # call to /networks/current.json to get the list of (known) networks.
      #
      # @param groups [Boolean] Whether or not to save Group memberships
      # @return [Platforms::User] The identity of the authenticated user
      def save_identity groups=true
        omni = request.env["omniauth.auth"]
        raw_info = omni.extra.raw_info

        # Get the network information, conveniently for all known networks
        # (should return an array)
        networks_response = client.networks.current

        current_network = nil
        networks = networks_response.body

        @switch_network_ids ||= []

        # Create a Platforms::Network, or update it with current details
        # if it already exists
        networks.each do |network|
          n = Platforms::Network.find_or_initialize_by(
            platform_id: network["id"]
          )
          n.name = network["name"]
          n.trial = bool_safe network["is_freemium"]
          n.permalink = network["permalink"]
          n.platform_type = "yammer"
          n.save!

          @switch_network_ids << n.id
          # Set @platform_network to the filtered network
          @platforms_network = n if raw_info.network_id.to_s == n.platform_id
        end

        user = Platforms::User.find_or_initialize_by(
          platform_id:       omni.uid,
          platforms_network: @platforms_network
        )
        user.name =          omni.info.name
        user.thumbnail_url = omni.info.image
        user.admin =         bool_safe raw_info.admin
        user.web_url =       omni.info.urls.yammer
        user.email =         omni.info.email
        user.save!
        @platforms_user = user

        # Switch for including groups 
        if groups
          current_user = client.users.
            current({include_group_memberships: true})
          sync_groups(current_user.body)
        end

        # Return @platforms_user
        @platforms_user
      end

      # Switch the current identity
      #
      # This does much the same as {#save_identity}, but the inputs are
      # very different.
      # This does not use the OmniAuth flow, but instead makes a
      # call to the authenticated API to get the required information.
      #
      # @param client [Client] The authenticated client
      # @param permalink [String] The network permalink to switch to
      # @param groups [Boolean] Whether or not to save Group memberships
      # @return [Platforms::User] The identity of the authenticated user, after
      # switching.
      def switch_identity client, permalink, groups=true

        # Do not use @client as that uses the token from OmniAuth.
        # switch_identity is designed to be used later in the user flow.
        tokens = client.oauth.tokens.body
        switch_network = tokens.find{ |t| t["network_permalink"] == permalink }

        # Raise error if the token is not found
        if switch_network.nil?
          raise ActiveRecord::RecordNotFound.new "Couldn't find Platforms::Network for permalink #{permalink}"
        end

        # Create a new Client with the updated token
        @token = switch_network["token"]
        switch_client = Platforms::Yammer::Client.new @token

        # Don't worry about updating Network here, should be done at first login.
        @platforms_network = Platforms::Network.find_by!(
          permalink: permalink,
          platform_type: "yammer"
        )

        # Switch for including groups
        current_options = groups ? { include_group_memberships: true } : {}
        switch_user = switch_client.users.current(current_options).body

        user = Platforms::User.find_or_initialize_by(
          platform_id:       switch_network["user_id"],
          platforms_network: @platforms_network
        )
        user.name =          switch_user["full_name"]
        user.thumbnail_url = switch_user["mugshot_url"]
        user.admin =         bool_safe switch_user["admin"]
        user.web_url =       switch_user["web_url"]
        user.email =         switch_user["email"]
        user.save!
        @platforms_user = user

        sync_groups(switch_user) if groups

        # Return @platforms_user
        @platforms_user
      end

      private

      def sync_groups api_groups
        # Expect data to have group_memberships key
        unless api_groups.has_key?("group_memberships")
          Rails.logger.warn "No Group membership data from users/current.json"
          return
        end

        membership = @platforms_user.platforms_group_members.pluck(:id)

        api_groups.fetch("group_memberships",[]).each do |g|
          role = g["admin"] ? "admin" : "member"

          group = Platforms::Group.find_or_initialize_by(
            platform_id: g["id"].to_s,
            platforms_network: @platforms_network
          )
          group.name = g["full_name"]
          group.web_url = g["web_url"]
          group.save!

          member = Platforms::GroupMember.find_or_initialize_by(
            platforms_user: @platforms_user,
            platforms_group: group
          )
          member.role = role
          member.save!

          membership.delete member.id
        end

        group_members = @platforms_user.platforms_group_members.
          where(id: membership)

        group_members.each do |d|
          d.destroy!
        end
      end

    end
  end
end
