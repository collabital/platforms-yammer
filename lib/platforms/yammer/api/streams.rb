module Platforms
  module Yammer
    module Api
      # The notification stream in Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class Streams < Base

        # Get the notifications stream for the current user
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/streamsnotificationsjson
        def notifications options={}, headers={}
          @connection.get "streams/notifications.json", options, headers
        end
      end
    end
  end
end

