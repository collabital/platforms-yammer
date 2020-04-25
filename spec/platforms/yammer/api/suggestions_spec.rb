require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Suggestions do
        include_context "API endpoints"

        describe "#get" do
          include_context "yammer GET", "suggestions.json"
          subject { api.get options, headers }
          it_behaves_like "api GET", "suggestions.json"
        end

        describe "#delete" do
          include_context "yammer DELETE", "suggestions/123.json"
          subject { api.delete 123, options, headers }
          it_behaves_like "api DELETE", "suggestions.json"
        end

      end
    end
  end
end
