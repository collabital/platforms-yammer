module Platforms
  module Yammer
    module Api
      # Open Graph Objects in Yammer
      #
      # This is read-only through the API.
      #
      # @author Benjamin Elias
      # @since 0.1.0
      class OpenGraphObjects < Base

        # Get open graph obects
        # URL is actually a required parameter so require that when
        # calling this function.
        # @param url [#to_s] URL of the OG item to get
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/open_graph_objects
        def get url, options={}, headers={}
          params = options.merge({url: url})
          @connection.get 'open_graph_objects.json', params, headers
        end

      end
    end
  end
end

