require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe UploadedFiles do
        include_context "API endpoints"

        describe "#delete" do
          include_context "yammer DELETE", "uploaded_files/123.json"
          subject { api.delete 123, options, headers }
          it_behaves_like "api DELETE", "uploaded_files/123.json"
        end

      end
    end
  end
end
