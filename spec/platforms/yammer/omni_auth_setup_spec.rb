require 'rails_helper'
require 'hashie'
require 'platforms/yammer/omni_auth_setup'

module Platforms
  module Yammer

    class AnonymousController < ApplicationController; end

    # Test this in the context of a controller, with env
    RSpec.describe AnonymousController, type: :controller do
      let(:strategy) { "yammer" }
      let(:server_name) { "www.example.com.au" }
      let(:credentials) { certificate.credentials.merge({name: strategy}) }
      let(:certificate) { FactoryBot.build(:certificate) }
      subject { JSON.parse(response.body).with_indifferent_access }

      before(:each) do
        omni_strategy = Hashie::Mash.new({options: {name: strategy}})
        allow(request.env).to receive(:[]).and_call_original
        allow(request.env).to receive(:[]).with("omniauth.strategy").and_return omni_strategy
        allow(request.env).to receive(:[]).with("SERVER_NAME").and_return server_name
        FactoryBot.create(:certificate)
      end

      controller do
        def index
          @output = OmniAuthSetup.call(request.env)
          render :plain => @output.to_json
        end
      end

      describe "domain and strategy match Certificate" do
        let(:server_name) { "Contoso.example.org" }
        let(:strategy) { "yammer" }
        it "returns valid credentials" do
          get :index
          expect(subject).to match credentials
        end
      end

      describe "strategy matches Certificate, domain does not match" do
        let(:certificate) { FactoryBot.build(:certificate, client_id: "abcd", client_secret: "1234") }
        it "returns empty credentials" do
          get :index
          expect(subject).to match credentials
        end
      end

      describe "domain matches Certificate, strategy does not match" do
        let(:certificate) { FactoryBot.build(:certificate, client_id: "abcd", client_secret: "1234") }
        let(:server_name) { "Contoso.example.org" }
        let(:strategy) { "gizmo" }
        it "returns empty credentials" do
          get :index
          expect(subject).to match credentials
        end
      end

    end
  end
end
