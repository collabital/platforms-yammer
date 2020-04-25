require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Invitations do
        include_context "API endpoints"

        describe "#post" do
          include_context "yammer POST", "invitations.json"
          let(:options) { {group_id: 208007, email: "q@bond.com"} }
          subject { api.post(options, headers) }
          it_behaves_like "api POST", "invitations.json"

          # Note changing the group to a non-existent group_id still
          # gets the same response from Yammer (200, status: ok)
          # as of 2020-03-25.
          #
          # This is not comprehensively tested, for example the "email1 to
          # email20" version of the parameters is not covered.
        end

      end
    end
  end
end
