require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Threads do
        include_context "API endpoints"

        describe "#get" do
          include_context "yammer GET", "threads/123.json"
          subject { api.get 123, options, headers }
          it_behaves_like "api GET", "threads/123.json"
        end

      end
    end
  end
end
