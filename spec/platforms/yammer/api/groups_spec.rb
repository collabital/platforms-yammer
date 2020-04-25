require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Groups do
        include_context "API endpoints"

        describe "#for_user" do
          include_context "yammer GET", "groups/for_user/123007.json"
          subject { api.for_user 123007, options, headers }
          it_behaves_like "api GET", "groups/for_user/123007.json"
        end

      end
    end
  end
end
