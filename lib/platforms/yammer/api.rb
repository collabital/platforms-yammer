require "platforms/yammer/api/base"
require "platforms/yammer/api/messages"
require "platforms/yammer/api/pending_attachments"
require "platforms/yammer/api/uploaded_files"
require "platforms/yammer/api/threads"
require "platforms/yammer/api/topics"
require "platforms/yammer/api/group_memberships"
require "platforms/yammer/api/groups"
require "platforms/yammer/api/users"
require "platforms/yammer/api/relationships"
require "platforms/yammer/api/streams"
require "platforms/yammer/api/suggestions"
require "platforms/yammer/api/subscriptions"
require "platforms/yammer/api/invitations"
require "platforms/yammer/api/search"
require "platforms/yammer/api/networks"
require "platforms/yammer/api/open_graph_objects"
require "platforms/yammer/api/oauth"
require "platforms/yammer/api/supervisor_mode"

module Platforms
  module Yammer
    # Module for all Yammer's API endpoints
    #
    # These are organised per-class in the 'directory' of the namespace.
    # Methods are generally called 'get', 'post', and 'delete' for simple
    # requests and named methods if more complex.
    #
    # For example:
    # * {Messages#get} maps to GET /messages.json
    # * {Messages#post} maps to POST /messages.json
    # * {Messages#my_feed} maps to GET /messages/my_feed.json
    #
    # @author Benjamin Elias
    # @since 0.1.0
    module Api
    end
  end
end
