module Platforms
  module Yammer
    module Api
      # Search within Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class Search < Base

        # Get search results
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/searchjson
        def get options={}, headers={}
          @connection.get 'search.json', options, headers
        end

      end
    end
  end
end

