require 'rails/generators'

module Platforms
  module Yammer

    # Simplify the installation of Platforms::Yammer by creating an
    # initializer file and installing the migrations.
    # This does not run the migrations.
    # @author Benjamin Elias
    # @since 0.1.0
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      # Create config/initializers/platforms_yammer.rb according
      # to the template.
      def copy_initializer_file
        copy_file "platforms_yammer.rb", "config/initializers/platforms_yammer.rb"
      end

      # Install Platforms::Core.
      # This uses the built in Rails generate method to call the
      # other gem's installer.
      def install_core
        generate "platforms:core:install"
      end

    end
  end
end
