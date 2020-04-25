require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe GroupMemberships do
        include_context "API endpoints"

        # Tested 2020-04-06, and Yammer generates a 200 response
        describe "#post" do
          include_context "yammer POST", "group_memberships.json"
          subject { api.post 208007, options, headers }
          it_behaves_like "api POST", "group_memberships.json"
        end

        describe "#delete" do
          include_context "yammer DELETE", "group_memberships.json"
          subject { api.delete 208007, options, headers }
          it_behaves_like "api DELETE", "group_memberships.json"
        end

      end
    end
  end
end
