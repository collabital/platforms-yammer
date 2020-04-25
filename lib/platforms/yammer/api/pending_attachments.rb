module Platforms
  module Yammer
    module Api
      # Pending attachments in Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class PendingAttachments < Base

        # Add a pending attachment
        # @param upload_io [Faraday::UploadIO] The file payload
        # @param options [Hash] Additional options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/pending_attachments
        # @see https://stackoverflow.com/questions/16725195/upload-files-using-faraday
        def post upload_io, options={}, headers={}
          body = { file: upload_io }.reverse_merge(options)
          @connection.post 'pending_attachments.json', body, headers
        end

        # Delete a pending attachment
        # @param id [#to_s] ID of pending attachment to delete
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/pending_attachmentsid
        def delete id, options={}, headers={}
          @connection.delete "pending_attachments/#{id}.json", options, headers
        end

      end
    end
  end
end
