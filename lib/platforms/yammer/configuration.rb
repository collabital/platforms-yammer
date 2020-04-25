module Platforms
  module Yammer

    # Configuration pattern for Rails, allows defaults and initializers to
    # override those defaults.
    # @see https://stackoverflow.com/a/24151439 Stack Overflow
    class << self

      # Get the configuration
      # @return [Configuration] the current configuration
      def configuration
        @configuration ||= Configuration.new
      end

      # Used by initializers to set the configuration
      # @yieldparam configuration [Configuration] the object to configure
      def configure
        yield configuration
      end
    end

    # The class which stores the gem's configuration
    # Should only store Yammer configuration options, other configuration
    # options should be made in core.
    #
    # @author Benjamin Elias
    # @since 0.1.0
    class Configuration
      include ActiveSupport::Configurable

      ##
      # The default client_id, if no saved {Platforms::Certificate} exists.
      # A saved Certificate will be used in preference to this default.
      # @return [String] the default client_id
      config_accessor(:client_id, instance_reader: false)

      def client_id
        if config[:client_id].blank?
          raise "Please configure Client ID as a non-empty value"
        elsif config[:client_id] == 'your_client_id'
          raise "Please configure Client ID as a real value, not 'your_client_id'"
        end
        config[:client_id]
      end

      ##
      # The default client_secret, if no saved {Platforms::Certificate} exists.
      # A saved Certificate will be used in preference to this default.
      # @return [String] the default client_secret
      config_accessor(:client_secret, instance_reader: false)

      def client_secret
        if config[:client_secret].blank?
          raise "Please configure Client Secret as a non-empty value"
        elsif config[:client_secret] == 'your_client_secret'
          raise "Please configure Client Secret as a real value, not 'your_client_secret'"
        end
        config[:client_secret]
      end

      ## 
      # The base Yammer URL for API requests. Defaults to
      # https://www.yammer.com/api/v1
      # @return [String] the base Yammer URL
      config_accessor(:api_base, instance_reader: false) do
        'https://www.yammer.com/api/v1'
      end

      def api_base
        URI.parse config[:api_base]
        config[:api_base]
      end

    end
  end
end
