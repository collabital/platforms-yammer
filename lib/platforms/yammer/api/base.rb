module Platforms
  module Yammer
    module Api
      # Base class taking care of common setup for Platforms::Yammer::Api
      # classes.
      # @author Benjamin Elias
      # @since 0.1.0
      class Base

        # Initialize with a Faraday connection
        # @param [Faraday::Connection] connection The connection to use
        def initialize connection
          @connection = connection
        end

      end
    end
  end
end

