require 'rails_helper'
require 'support/contexts/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe Base do
        include_context "API endpoints"

        it { expect(Base.new connection).to be_a Platforms::Yammer::Api::Base }
      end

    end
  end
end
