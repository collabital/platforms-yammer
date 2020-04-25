module Platforms
  module Yammer
    module Api
      # Threads in Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class Threads < Base

        # Get information about a thread
        # @param id [#to_s] The thread ID
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/threadsidjson
        def get id, options={}, headers={}
          @connection.get "threads/#{id}.json", options, headers
        end

      end
    end
  end
end

