module Platforms
  module Yammer

    # Isolated Rails Engine
    # @see https://guides.rubyonrails.org/engines.html
    #
    # @author Benjamin Elias
    # @since 0.1.0
    class Engine < ::Rails::Engine

      # Isolate namespace, as generally required for gems
      isolate_namespace Platforms::Yammer

      # Use RSpec and FactoryBot
      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_bot
        g.factory_bot dir: 'spec/factories'
      end

      # Set factory paths for FactoryBot
      initializer "platforms.factories", :after => "factory_bot.set_factory_paths" do
        FactoryBot.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryBot)
      end
    end
  end
end
