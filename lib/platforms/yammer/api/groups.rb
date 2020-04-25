module Platforms
  module Yammer
    module Api
      # Groups in Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class Groups < Base

        # Get group memberships for a user
        # @param user_id [#to_s] The user to query for memberships
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/groupsfor_useruser_idjson
        def for_user user_id, options={}, headers={}
          @connection.get "groups/for_user/#{user_id}.json", options, headers
        end
      end
    end
  end
end

