require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Networks do
        include_context "API endpoints"

        describe "#current" do
          include_context "yammer GET", "networks/current.json"
          subject { api.current options, headers }
          it_behaves_like "api GET", "networks/current.json"
        end

      end
    end
  end
end
