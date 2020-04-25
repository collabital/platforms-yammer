module Platforms
  module Yammer
    module Api
      # Yammer's subscription (following) management
      # @author Benjamin Elias
      # @since 0.1.0
      class Subscriptions < Base

        # Check if the current user is subscribed to (following) another user
        # @param id [#to_s] The ID of the User
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/subscriptionsto_useridjson
        def to_user id, options={}, headers={}
          @connection.get "subscriptions/to_user/#{id}.json", options, headers
        end

        # Check if the current user is subscribed to (following) a topic (hashtag)
        # @param id [#to_s] The ID of the User
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/subscriptionsto_topicidjson
        def to_topic id, options={}, headers={}
          @connection.get "subscriptions/to_topic/#{id}.json", options, headers
        end

        # Subscribe to a user or topic.
        # This usually involves setting target_id and target_type in the JSON body.
        # @param body [#to_s] Body of the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/subscriptions-1
        def post body=nil, headers={}
          @connection.post "subscriptions.json", body, headers
        end

        # Unsubscribe from a user or topic.
        # This usually involves setting target_id and target_type in the options hash.
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/subscriptions-1
        def delete options={}, headers={}
          @connection.delete "subscriptions.json", options, headers
        end

      end
    end
  end
end

