require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Streams do
        include_context "API endpoints"

        describe "#notifications" do
          include_context "yammer GET", "streams/notifications.json"
          subject { api.notifications options, headers }
          it_behaves_like "api GET", "streams/notifications.json"
        end

      end
    end
  end
end
