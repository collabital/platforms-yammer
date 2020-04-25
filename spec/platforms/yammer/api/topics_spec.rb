require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Topics do
        include_context "API endpoints"

        describe "#get" do
          include_context "yammer GET", "topics/123.json"
          subject { api.get 123, options, headers }
          it_behaves_like "api GET", "topics/123.json"
        end

      end
    end
  end
end
