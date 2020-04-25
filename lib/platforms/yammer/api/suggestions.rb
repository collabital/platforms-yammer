module Platforms
  module Yammer
    module Api
      # Yammer's suggestions for Users to follow
      # @author Benjamin Elias
      # @since 0.1.0
      class Suggestions < Base

        # Get suggested users to follow for the current user
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/suggestionsjson
        def get options={}, headers={}
          @connection.get "suggestions.json", options, headers
        end

        # Decline a suggested user to follow
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/suggestionsidjson
        def delete suggestion_id, options={}, headers={}
          @connection.delete "suggestions/#{suggestion_id}.json", options, headers
        end

      end
    end
  end
end

