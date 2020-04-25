require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Search do
        include_context "API endpoints"

        describe "#get" do
          let(:options) { { search: "find" } }
          include_context "yammer GET", "search.json"
          subject { api.get options, headers }
          it_behaves_like "api GET", "search.json"
        end

      end
    end
  end
end
