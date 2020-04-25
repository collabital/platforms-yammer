module Platforms
  module Yammer
    module Api
      # Relationships in Yammer
      # @todo confirm documentation, which currently (2020-03-25) is confused
      # around parameters and mentions updating relationships as part of a
      # GET request
      #
      # @author Benjamin Elias
      # @since 0.1.0
      class Relationships < Base

        # Get relationships
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/relationshipsjson
        def get options={}, headers={}
          @connection.get 'relationships.json', options, headers
        end


        # Update relationships
        #
        # It is unclear how exactly this works with subordinates, and "all
        # three can be passed in one request".
        #
        # @param options [Hash] Options for the request body
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/relationshipsjson-1
        def post options={}, headers={}
          @connection.post 'relationships.json', options, headers
        end

      end
    end
  end
end
