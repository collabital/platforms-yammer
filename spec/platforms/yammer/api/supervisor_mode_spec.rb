require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe SupervisorMode do
        include_context "API endpoints"

        describe "#post" do
          include_context "yammer POST", "supervisor_mode/toggle.json"
          subject { api.toggle options, headers }
          it_behaves_like "api POST", "supervisor_mode/toggle.json"
        end

      end
    end
  end
end
