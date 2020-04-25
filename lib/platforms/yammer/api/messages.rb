module Platforms
  module Yammer
    module Api
      # Messaging endpoints for the Yammer API
      # @author Benjamin Elias
      # @since 0.1.0
      class Messages < Base

        # Get Messages from my feed
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesmy_feedjson
        def my_feed options={}, headers={}
          @connection.get "messages/my_feed.json", options, headers
        end

        # Get Messages through the algorithmic feed
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesalgojson
        def algo options={}, headers={}
          @connection.get "messages/algo.json", options, headers
        end

        # Get all messages
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesjson
        def get options={}, headers={}
          @connection.get "messages.json", options, headers
        end

        # Get messages in 'following' feed
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesfollowingjson
        def following options={}, headers={}
          @connection.get "messages/following.json", options, headers
        end

        # Sent messages
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagessentjson
        def sent options={}, headers={}
          @connection.get "messages/sent.json", options, headers
        end

        # Private messages
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesprivatejson
        def private options={}, headers={}
          @connection.get "messages/private.json", options, headers
        end

        # Received messages
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesreceivedjson
        def received options={}, headers={}
          @connection.get "messages/received.json", options, headers
        end

        # Messages in a thread
        # @param thread_id [#to_s] The thread ID
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesin_threadthreadidjson
        def in_thread thread_id, options={}, headers={}
          @connection.get "messages/in_thread/#{thread_id}.json", options, headers
        end

        # Messages in a group
        # @param group_id [#to_s] The group ID
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesin_groupgroup_id
        def in_group group_id, options={}, headers={}
          @connection.get "messages/in_group/#{group_id}.json", options, headers
        end

        # Messages about an Open Graph object
        # @param id [#to_s] The Open Graph ID to filter by
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesopen_graph_objects
        def open_graph_objects id, options={}, headers={}
          @connection.get "messages/open_graph_objects/#{id}.json", options, headers
        end

        # Messages about a topic
        # @param topic_id [#to_s] The topic to filter by
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesabout_topicidjson
        def about_topic topic_id, options={}, headers={}
          @connection.get "messages/about_topic/#{topic_id}.json", options, headers
        end

        # Post a new message
        # @param body [#to_s] Body of the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messages-json-post
        def post body, headers={}
          @connection.post "messages.json", body, headers
        end

        # E-mail a copy of the message to the current user
        # @param message_id [#to_s] The ID of the message to delete
        # @param body [#to_s] Body of the request (should not need to be used)
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesemail
        def email message_id, body=nil, headers={}
          @connection.post "messages/email.json?message_id=#{message_id}", body, headers
        end

        # Like a message
        # @param message_id [#to_s] The ID of the message to delete
        # @param body [#to_s] Body of the request (should not need to be used)
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesliked_bycurrentjsonmessage_idid
        def like message_id, body=nil, headers={}
          @connection.post "messages/liked_by/current.json?message_id=#{message_id}", body, headers
        end

        # Unlike a message
        # @param message_id [#to_s] The ID of the message to delete
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesliked_bycurrentjsonmessage_idid-1
        def unlike message_id, options=nil, headers={}
          @connection.delete "messages/liked_by/current.json?message_id=#{message_id}", options, headers
        end

        # Delete a message
        # @param message_id [#to_s] The ID of the message to delete
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/messagesid
        def delete message_id, options=nil, headers={}
          @connection.delete "messages/#{message_id}.json", options, headers
        end

      end
    end
  end
end

