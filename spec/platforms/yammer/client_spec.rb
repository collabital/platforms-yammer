require 'rails_helper'
require 'platforms/yammer/client'

module Platforms
  module Yammer

    RSpec.shared_examples "API module" do |mod|
      let(:klass) { Api.const_get(mod.camelize) }

      it { expect(client.send(mod)).to be_a klass }
      describe "constructor" do
        before(:each) do
          allow(klass).to receive(:new).with(client.connection)
          client.send(mod)
        end
        it "received #new with Faraday::Connection" do
          expect(klass).to have_received(:new).
            once.
            with(client.connection)
        end
      end
    end

    RSpec.shared_examples "generic GET request" do
      before(:each) do
        stub_request(:get, "#{api_base}/nonexist/current.json?a=b").
          with(
            headers:
            {
              'Authorization' => "Bearer #{token}",
              'Custom' => "headings"
            }
        ).
        to_return(
          body: body.to_json,
          headers: {
            "CONTENT-TYPE" => "application/json"
          }
        )
      end

      it "response" do
        response = client.request :get, "nonexist/current.json", { a: "b" }, headers
        expect(response.body).to match(body)
      end
    end


    # Test this in the context of a controller, with env
    RSpec.describe Client do
      let(:token)  { "shakenn0tst1rr3d" }
      let(:client) { Client.new token }

      describe "#new" do
        it { expect(client).to be_a Platforms::Yammer::Client }
        it { expect(client.connection).to be_a Faraday::Connection }
      end

      describe "#request" do
        let(:headers)  { { "custom" => "headings" } }
        let(:body)     { { hello: "world" }.with_indifferent_access }
        let(:api_base) { "https://www.yammer.com/api/v1" }

        describe "with client block" do
          let(:client) do
            Client.new token do |f|
              f.use Faraday::Response::RaiseError
            end
          end

          before(:each) do
            stub_request(:get, "#{api_base}/nonexist/current.json").
              with(
                headers:
                {
                  'Authorization' => "Bearer #{token}",
                }
            ).
            to_return(
              status: 401,
              body: "Not Authorized"
            )
          end

          it do
            expect { client.request :get, "nonexist/current.json" }.
               to raise_error Faraday::UnauthorizedError
          end
        end

        describe "GET with endpoint and query string" do
          it_behaves_like "generic GET request"
        end

        describe "POST with endpoint and body" do
          let(:params) { {"a" => "b"}.to_json }
          before(:each) do
            stub_request(:post, "#{api_base}/nonexist/current.json").
              with(
                headers: {
                  'Authorization' => "Bearer #{token}",
                  'Custom' => "headings"
                },
                body: params
            ).
            to_return(
              body: body.to_json,
              headers: {
                "CONTENT-TYPE" => "application/json"
              }
            )
          end
          it "response" do
            response = client.request :post, "nonexist/current.json", params, headers
            expect(response.body).to match(body)
          end
        end

        describe "GET with alternative endpoint" do
          let(:api_base) { "https://www.yammer.com/api/v2" }

          before(:each) do
            Platforms::Yammer.configure do |c|
              c.api_base = api_base
            end
          end

          after(:each) do
            Platforms::Yammer.configure do |c|
              c.api_base = "https://www.yammer.com/api/v1"
            end
          end

          it_behaves_like "generic GET request"
        end
      end

      it_behaves_like "API module", "messages"
      it_behaves_like "API module", "pending_attachments"
      it_behaves_like "API module", "uploaded_files"
      it_behaves_like "API module", "threads"
      it_behaves_like "API module", "topics"
      it_behaves_like "API module", "group_memberships"
      it_behaves_like "API module", "groups"
      it_behaves_like "API module", "users"
      it_behaves_like "API module", "relationships"
      it_behaves_like "API module", "streams"
      it_behaves_like "API module", "suggestions"
      it_behaves_like "API module", "subscriptions"
      it_behaves_like "API module", "invitations"
      it_behaves_like "API module", "search"
      it_behaves_like "API module", "networks"
      it_behaves_like "API module", "open_graph_objects"
      it_behaves_like "API module", "supervisor_mode"
      it_behaves_like "API module", "oauth"
    end
  end
end
