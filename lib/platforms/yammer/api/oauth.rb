module Platforms
  module Yammer
    module Api
      # OAuth2 tokens in Yammer, useful for verified admins to impoersonate
      # other users, or to switch networks.
      #
      # @note This class is called Oauth and not OAuth (or OAuth2), because
      #   of the syntax of the Yammer API path.
      #   There is no underscore between the O and A.
      #
      # @author Benjamin Elias
      # @since 0.1.0
      class Oauth < Base

        # Get tokens
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/impersonation
        def tokens options={}, headers={}
          @connection.get "oauth/tokens.json", options, headers
        end

      end
    end
  end
end

