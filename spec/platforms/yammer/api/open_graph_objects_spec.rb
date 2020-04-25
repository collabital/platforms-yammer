require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe OpenGraphObjects do
        include_context "API endpoints"

        describe "#get" do
          let(:url) { "http://example.com/" }
          include_context "yammer GET", "open_graph_objects.json"
          subject { api.get url, options, headers }
          it_behaves_like "api GET", "open_graph_objects.json"
        end

      end
    end
  end
end
