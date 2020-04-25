require 'platforms/core'
require 'platforms/yammer/configuration'

module Platforms
  module Yammer

    # Yammer-specific requirements for OmniAuth setup.
    # Sets the default certificate to the {Configuration} values.
    # Setting Client ID and Client Secret are done in Platforms::Core:OmniAuthSetup
    #
    # @author Benjamin Elias
    # @since 0.1.0
    # @see https://www.createdbypete.com/dynamic-omniauth-provider-setup/ Dynamic providers.
    # @see https://github.com/omniauth/omniauth/wiki/Setup-Phase OmniAuth Setup Phase
    class OmniAuthSetup < ::Platforms::Core::OmniAuthSetup

      # Create a Certificate with the default configuration setup
      # according to the {Configuration} for client_id and client_secret,
      # usually specified in the gem's initializer.
      # This can be used if there is no Certificate saved in the database.
      # @return [Platforms::Certificate] the Certificate to use by default
      def default_certificate
        Certificate.new do |c|
          c.client_id =     Platforms::Yammer.configuration.client_id
          c.client_secret = Platforms::Yammer.configuration.client_secret
        end
      end

    end
  end
end
