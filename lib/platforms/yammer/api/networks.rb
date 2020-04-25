module Platforms
  module Yammer
    module Api
      # Networks on Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class Networks < Base

        # Get the user's current Network
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/networkscurrentjson
        def current options={}, headers={}
          @connection.get 'networks/current.json', options, headers
        end

      end
    end
  end
end

