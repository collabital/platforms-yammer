module Platforms
  module Yammer
    module Api
      # Uploaded file in Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class UploadedFiles < Base

        # Delete an uploaded file
        # @param id [#to_s] ID of file to delete
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/uploaded_filesid
        def delete id, options={}, headers={}
          @connection.delete "uploaded_files/#{id}.json", options, headers
        end

      end
    end
  end
end
