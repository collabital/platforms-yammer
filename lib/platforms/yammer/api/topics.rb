module Platforms
  module Yammer
    module Api
      # Topics in Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class Topics < Base

        # Get information about a topic (hashtag)
        # @param id [#to_s] The topic ID
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/topicsidjson
        def get id, options={}, headers={}
          @connection.get "topics/#{id}.json", options, headers
        end

      end
    end
  end
end

