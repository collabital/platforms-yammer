require 'rails_helper'
require 'support/contexts/api'
require 'support/examples/api'

module Platforms
  module Yammer
    module Api

      RSpec.describe PendingAttachments do
        include_context "API endpoints"

        describe "#post" do
          let(:upload_path) { "#{Rails.root}/public/profile.png" }
          let(:upload_io) { Faraday::UploadIO.new(upload_path, "image/png") }

          include_context "yammer POST", "pending_attachments.json"
          subject { api.post upload_io, options, headers }
          it_behaves_like "api POST", "pending_attachments.json"
        end

        describe "#delete" do
          include_context "yammer DELETE", "pending_attachments/99007.json"
          subject { api.delete 99007, options, headers }
          it_behaves_like "api DELETE", "pending_attachments/99007.json"
        end

      end
    end
  end
end
