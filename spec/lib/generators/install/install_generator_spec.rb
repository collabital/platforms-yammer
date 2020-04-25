require 'spec_helper'
require 'generators/platforms/yammer/install/install_generator'

module Platforms
  module Yammer
    RSpec.describe InstallGenerator, type: :generator do
      destination File.expand_path('../../tmp', __FILE__)

      let(:mock_gen) do
        InstallGenerator.new(
          [],
          ["--skip-bundle", "--skip-bootsnap", "--skip-webpack-install"],
          {
            destination_root: File.expand_path('../../tmp', __FILE__),
            shell: Thor::Shell::Basic.new
          }
        )
      end


      before(:each) do
        # Stub out #rake in a known instance
        allow(mock_gen).to receive(:generate)

        # Stub out 'new' method, in order to set the mocked instance
        allow(described_class).to receive(:new).with(
          [],
          ["--skip-bundle", "--skip-bootsnap", "--skip-webpack-install"],
          {
            destination_root: File.expand_path('../../tmp', __FILE__),
            shell: instance_of(Thor::Shell::Basic)
          }
        ).and_return(mock_gen)

        prepare_destination
        run_generator
      end

      it "copies platforms_yammer.rb initializer" do
        expect(destination_root).to have_structure {
          directory "config" do
            directory "initializers" do
              file "platforms_yammer.rb" do
                contains "Platforms::Yammer.configure do |config|"
              end
            end
          end
        }
      end

      it "ran 'rails generate platforms:core:install" do
        expect(mock_gen).to have_received(:generate).
          with("platforms:core:install").
          once
      end

    end
  end
end
