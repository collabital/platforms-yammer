require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Subscriptions do
        include_context "API endpoints"

        describe "#to_user" do
          include_context "yammer GET", "subscriptions/to_user/87.json"
          subject { api.to_user 87, options, headers }
          it_behaves_like "api GET", "subscriptions/to_user/87.json"
        end

        describe "#to_topic" do
          include_context "yammer GET", "subscriptions/to_topic/87.json"
          subject { api.to_topic 87, options, headers }
          it_behaves_like "api GET", "subscriptions/to_topic/87.json"
        end

        describe "#post" do
          include_context "yammer POST", "subscriptions.json"
          let(:options) { { target_id: 86, target_type: "topic" } }
          subject { api.post options, headers }
          it_behaves_like "api POST", "subscriptions.json"
        end

        describe "#delete" do
          include_context "yammer DELETE", "subscriptions.json"
          let(:options) { { target_id: 86, target_type: "topic" } }
          subject { api.delete options, headers }
          it_behaves_like "api DELETE", "subscriptions.json"
        end

      end
    end
  end
end
