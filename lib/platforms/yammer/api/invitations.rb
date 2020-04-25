module Platforms
  module Yammer
    module Api
      # Invite people to a Yammer network
      # @author Benjamin Elias
      # @since 0.1.0
      class Invitations < Base

        # Post invitations
        # @param body [#to_s] Body of the request. Typically has email and may
        # have group_id (optional).
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/invitationsjson
        def post body=nil, headers={}
          @connection.post "invitations.json", body, headers
        end

      end
    end
  end
end

