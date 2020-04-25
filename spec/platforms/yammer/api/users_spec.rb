require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Users do
        include_context "API endpoints"

        describe "#get_users" do
          include_context "yammer GET", "users.json"
          subject { api.get_users options, headers }
          it_behaves_like "api GET", "users.json"
        end

        describe "#current" do
          include_context "yammer GET", "users/current.json"
          subject { api.current options, headers }
          it_behaves_like "api GET", "users/current.json"
        end

        describe "#get_user" do
          include_context "yammer GET", "users/123.json"
          subject { api.get_user 123, options, headers }
          it_behaves_like "api GET", "users/123.json"
        end

        describe "#by_email" do
          include_context "yammer GET", "users/by_email.json"
          subject { api.by_email "me@example.com", options, headers }
          it_behaves_like "api GET", "users/by_email.json"
        end

        describe "#in_group" do
          include_context "yammer GET", "users/in_group/123.json"
          subject { api.in_group 123, options, headers }
          it_behaves_like "api GET", "users/in_group/123.json"
        end

        describe "#liked_message" do
          include_context "yammer GET", "users/liked_message/123.json"
          subject { api.liked_message 123, options, headers }
          it_behaves_like "api GET", "users/liked_message/123.json"
        end

        describe "#post" do
          let(:options) { { email: "me@example.com", full_name: "Example User" } }
          include_context "yammer POST", "users.json"
          subject { api.post options, headers }
          it_behaves_like "api POST", "users.json"
        end

        describe "#put" do
          let(:options) { { email: "me@example.com" } }
          include_context "yammer PUT", "users/123.json"
          subject { api.put 123, options, headers }
          it_behaves_like "api PUT", "users/123.json"
        end

        describe "#delete" do
          include_context "yammer DELETE", "users/123.json"
          subject { api.delete 123, options, headers }
          it_behaves_like "api DELETE", "users/123.json"
        end

      end
    end
  end
end
