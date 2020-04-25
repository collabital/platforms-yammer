module Platforms
  module Yammer
    module Api
      # Set supervisor mode in Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class SupervisorMode < Base

        # Toggle supervisor mode
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/api-requests
        def toggle options={}, headers={}
          @connection.post "supervisor_mode/toggle.json", options, headers
        end

      end
    end
  end
end

