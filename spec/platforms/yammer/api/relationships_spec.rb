require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Relationships do
        include_context "API endpoints"

        # In testing, this doesn't actually work for the proper
        # Yammer site. Given it's officially documented, it should be
        # supported by this library.
        describe "#get" do
          include_context "yammer GET", "relationships.json"
          subject { api.get options, headers }
          it_behaves_like "api GET", "relationships.json"
        end

        # In testing, this doesn't actually work for the proper
        # Yammer site. Given it's officially documented, it should be
        # supported by this library.
        describe "#post" do
          include_context "yammer POST", "relationships.json"
          let(:options) { { target_id: 86, target_type: "topic" } }
          subject { api.post options, headers }
          it_behaves_like "api POST", "relationships.json"
        end

      end
    end
  end
end
