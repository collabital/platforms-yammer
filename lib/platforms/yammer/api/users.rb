module Platforms
  module Yammer
    module Api
      # Users in Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class Users < Base

        # Get Users
        #
        # @note Called #get_users because of the potential confusion with
        # GET /users/[:id].json
        #
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/usersjson
        def get_users options={}, headers={}
          @connection.get "users.json", options, headers
        end

        # Get current User
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/userscurrentjson
        def current options={}, headers={}
          @connection.get "users/current.json", options, headers
        end

        # Get a User by id
        #
        # @note Called #get_user because of the potential confusion with
        # GET /users.json
        #
        # @param id [#to_s] id of the User
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/usersidjson
        def get_user id, options={}, headers={}
          @connection.get "users/#{id}.json", options, headers
        end

        # Get a User by email
        # @param address [#to_s] email of the User
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/usersby_emailjsonemailuserdomaincom
        def by_email address, options={}, headers={}
          params = options.merge({ email: address })
          @connection.get "users/by_email.json", params, headers
        end

        # Get a Users in a Group
        # @param group_id [#to_s] id of the Group
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/usersin_groupidjson
        def in_group group_id, options={}, headers={}
          @connection.get "users/in_group/#{group_id}.json", options, headers
        end

        # Get Users who have liked a Message
        # @param message_id [#to_s] id of the Message
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/usersliked_messagemessage_idjson
        def liked_message message_id, options={}, headers={}
          @connection.get "users/liked_message/#{message_id}.json", options, headers
        end

        # Create a new User (verified admins only)
        # @param body [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/usersjson-1
        def post body=nil, headers={}
          @connection.post "users.json", body, headers
        end

        # Update an existing User (verified admins only)
        # @param user_id [#to_s] the id of the User to update
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/usersidjson-1
        def put user_id, options={}, headers={}
          @connection.put "users/#{user_id}.json", options, headers
        end

        # Delete an existing User (admins and verified admins only)
        # @param user_id [#to_s] the id of the User to update
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/usersidjson-2
        def delete user_id, options={}, headers={}
          @connection.delete "users/#{user_id}.json", options, headers
        end

      end
    end
  end
end

