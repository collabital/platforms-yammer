require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Messages do
        include_context "API endpoints"

        # Get following or top conversations feed
        # @see https://developer.yammer.com/docs/messagesmy_feedjson
        describe "#my_feed" do
          include_context "yammer GET", "messages/my_feed.json"
          subject { api.my_feed options, headers }
          it_behaves_like "api GET", "messages/my_feed.json"
        end

        # Get algorithmic feed
        # @see https://developer.yammer.com/docs/messagesalgojson
        describe "#algo_feed" do
          include_context "yammer GET", "messages/algo.json"
          subject { api.algo options, headers }
          it_behaves_like "api GET", "messages/algo.json"
        end

        # Get 'All' messages
        # @see https://developer.yammer.com/docs/messagesjson
        describe "#get" do
          include_context "yammer GET", "messages.json"
          subject { api.get options, headers }
          it_behaves_like "api GET", "messages.json"
        end

        # Get following messages
        # @see https://developer.yammer.com/docs/messagesfollowingjson
        describe "#following" do
          include_context "yammer GET", "messages/following.json"
          subject { api.following options, headers }
          it_behaves_like "api GET", "messages/following.json"
        end

        # Get sent messages
        # https://developer.yammer.com/docs/messagessentjson
        describe "#sent" do
          include_context "yammer GET", "messages/sent.json"
          subject { api.sent options, headers}
          it_behaves_like "api GET", "messages/sent.json"
        end

        # Get private messages
        # @see https://developer.yammer.com/docs/messagesprivatejson
        describe "#private" do
          include_context "yammer GET", "messages/private.json"
          subject { api.private options, headers}
          it_behaves_like "api GET", "messages/private.json"
        end

        describe "#received" do
          include_context "yammer GET", "messages/received.json"
          subject { api.received options, headers}
          it_behaves_like "api GET", "messages/received.json"
        end

        describe "#in_thread" do
          include_context "yammer GET", "messages/in_thread/123.json"
          subject { api.in_thread 123, options, headers}
          it_behaves_like "api GET", "messages/in_thread/123.json"
        end

        describe "#in_group" do
          include_context "yammer GET", "messages/in_group/123.json"
          subject { api.in_group 123, options, headers}
          it_behaves_like "api GET", "messages/in_group/123.json"
        end

        describe "#open_graph_objects" do
          include_context "yammer GET", "messages/open_graph_objects/123.json"
          subject { api.open_graph_objects 123, options, headers}
          it_behaves_like "api GET", "messages/open_graph_objects/123.json"
        end

        describe "#about_topic" do
          include_context "yammer GET", "messages/about_topic/123.json"
          subject { api.about_topic 123, options, headers}
          it_behaves_like "api GET", "messages/about_topic/123.json"
        end

        describe "#post" do
          let(:options) { {body: "Hello world!" } }
          include_context "yammer POST", "messages.json"
          subject { api.post options, headers}
          it_behaves_like "api POST", "messages.json"
        end

        describe "#email" do
          include_context "yammer POST", "messages/email.json?message_id=123"
          subject { api.email 123, options, headers}
          it_behaves_like "api POST", "messages/email.json?message_id=123"
        end

        describe "#like" do
          include_context "yammer POST", "messages/liked_by/current.json?message_id=123"
          subject { api.like 123, options, headers}
          it_behaves_like "api POST", "messages/liked_by/current.json?message_id=123"
        end

        describe "#unlike" do
          include_context "yammer DELETE", "messages/liked_by/current.json"
          subject { api.unlike 123, options, headers}
          it_behaves_like "api DELETE", "messages/liked_by/current.json"
        end

        describe "#delete" do
          include_context "yammer DELETE", "messages/123.json"
          subject { api.delete 123, options, headers}
          it_behaves_like "api DELETE", "messages/123.json"
        end

      end
    end
  end
end
