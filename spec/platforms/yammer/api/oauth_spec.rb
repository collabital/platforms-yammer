require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Oauth do
        include_context "API endpoints"

        describe "#tokens" do
          include_context "yammer GET", "oauth/tokens.json"
          subject { api.tokens options, headers }
          it_behaves_like "api GET", "oauth/tokens.json"
        end

      end
    end
  end
end
