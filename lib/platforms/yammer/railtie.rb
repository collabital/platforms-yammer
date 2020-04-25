require 'omniauth'
require 'omniauth-yammer'
require 'platforms/yammer/omni_auth_setup'

module Platforms
  module Yammer

    # Railtie to configure OmniAuth with {OmniAuthSetup}
    # @author Benjamin Elias
    # @since 0.1.0
    class Railtie < ::Rails::Railtie
      initializer "configure OmniAuth for Yammer" do |app|
        app.config.middleware.use ::OmniAuth::Builder do
          provider :yammer, setup: OmniAuthSetup
        end
      end
    end
  end
end
