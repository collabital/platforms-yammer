module Platforms
  module Yammer
    module Api
      # Group memberships in Yammer
      # @author Benjamin Elias
      # @since 0.1.0
      class GroupMemberships < Base

        # Join a Group
        # @param group_id [#to_s] The ID of the Group to join
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/group_membershipsjsongroup_idid
        def post group_id, options={}, headers={}
          body = options.merge({ group_id: group_id})
          @connection.post 'group_memberships.json', body, headers
        end

        # Leave a Group
        # @param group_id [#to_s] ID of Group to leave
        # @param options [Hash] Options for the request
        # @param headers [Hash] Additional headers to send with the request
        # @return [Faraday::Response] the API response
        # @see https://developer.yammer.com/docs/group_membershipsjsongroup_idid-1
        def delete group_id, options={}, headers={}
          params = options.merge({group_id: group_id})
          @connection.delete 'group_memberships.json', params, headers
        end

      end
    end
  end
end

