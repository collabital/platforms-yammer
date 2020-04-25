require 'spec_helper'
require 'platforms/yammer/configuration'

module Platforms

  RSpec.describe Yammer do

    # Need to restore configuration, as the configuration
    # persists across tests. This should match whatever is in
    # spec/dummy/config/initializers/platforms_yammer.rb
    after(:each) do
      described_class.configure do |c|
        c.client_id =     "abcd"
        c.client_secret = "1234"
        c.api_base =      "https://www.yammer.com/api/v1"
      end
    end

    describe "with configuration" do
      before(:each) do
        described_class.configure do |c|
          c.client_id =     'my_client_id'
          c.client_secret = 'my_client_secret'
        end
      end
      subject { described_class.configuration }

      it { expect(subject.client_id).to eq     "my_client_id" }
      it { expect(subject.client_secret).to eq "my_client_secret" }
      it { expect(subject.api_base).to eq      "https://www.yammer.com/api/v1" }
    end

    describe "with invalid configuration" do

      it "default client_id" do
        described_class.configure do |c|
          c.client_id = 'your_client_id'
        end
        expect{ described_class.configuration.client_id }.
          to raise_error(
            "Please configure Client ID as a real value, not 'your_client_id'"
        )
      end

      it "default client_secret" do
        described_class.configure do |c|
          c.client_secret = 'your_client_secret'
        end
        expect{ described_class.configuration.client_secret }.
          to raise_error(
            "Please configure Client Secret as a real value, not 'your_client_secret'"
        )
      end

      it "invalid api_base" do
        described_class.configure do |c|
          c.api_base = "not really a URL"
        end
        expect{ described_class.configuration.api_base }.
          to raise_error(URI::InvalidURIError)
      end

    end

    describe "with empty configuration" do

      it "empty client_id" do
        described_class.configure do |c|
          c.client_id = nil
        end
        expect{ described_class.configuration.client_id }.
          to raise_error(
            "Please configure Client ID as a non-empty value"
        )
      end

      it "empty client_secret" do
        described_class.configure do |c|
          c.client_secret = nil
        end
        expect{ described_class.configuration.client_secret }.
          to raise_error(
            "Please configure Client Secret as a non-empty value"
        )
      end

      it "empty api_base" do
        described_class.configure do |c|
          c.api_base = nil
        end
        expect{ described_class.configuration.api_base }.
          to raise_error(URI::InvalidURIError)
      end

    end


  end
end
