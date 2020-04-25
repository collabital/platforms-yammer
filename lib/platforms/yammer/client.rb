require 'faraday'
require 'faraday_middleware'
require 'platforms/yammer/api'

module Platforms
  module Yammer
    # A REST client for Yammer
    #
    # Assumes all of the OAuth2 authentication has been done previously,
    # and a valid token is available.
    #
    # Uses Faraday to conduct HTTP requests and receive responses, with
    # OAuth2 FaradayMiddleWare.
    #
    # @author Benjamin Elias
    # @since 0.1.0
    class Client

      # Giving access to the underlying Faraday connection allows setting
      # headers and other more detailed configuration.
      # @return [Faraday::Connection] the Faraday connection
      attr_reader :connection

      # Initialize class with a token
      #
      # Construct a new Faraday {#connection} which uses the token provided.
      # Uses OAuth2 with Bearer authentication.
      #
      # Requests are sent with JSON encoding by default, and responses
      # are parsed as JSON if the Content-type header of the response
      # is set accordingly.
      #
      # To change the default base URL, use the {Configuration} settings
      # in an initializer.
      #
      # Connection configuration can be performed using the yield block,
      # or can be done through the {#connection} variable as shown in the
      # examples.
      #
      # To override default connection headers with request-specific headers,
      # use the headers parameter in any of the request functions.
      #
      # Errors can be turned off if the application explicitly checks the
      # HTTP status codes. By default these are left on.
      #
      # @example Configure Faraday at initialization
      #   client = Client.new(token) do |f|
      #     f.use(Faraday::Response::RaiseError)
      #   end
      # @example Configure Faraday after initialization
      #   client = Client.new(token)
      #   client.connection.use(Faraday::Response::RaiseError)
      #
      # @param token [String] the token to use
      # @param errors [Boolean] whether to raise errors for non-2XX responses
      # @yieldparam f [::Faraday] the new Faraday connection
      def initialize token, errors=true, &block
        api_base = Platforms::Yammer.configuration.api_base

        @connection = ::Faraday.new api_base do |faraday|
          faraday.request :oauth2, token, token_type: 'bearer'
          faraday.request :json
          faraday.response :json, :content_type => /\bjson$/
          faraday.use Faraday::Response::RaiseError if errors
          block.call(faraday) if block_given?
        end
      end

      # Generic request, can be used for new, updated, or
      # undocumented endpoints.
      # @param method [Symbol] The HTTP method (get, post, put, delete)
      # @param endpoint [String] The API endpoint
      # @param options [Hash] Options for the request
      # @param headers [Hash] Headers to include with the request
      # @return [Faraday::Response] the Faraday response
      def request method, endpoint, options={}, headers={}
        connection.send(method, endpoint, options, headers)
      end

      # Create new {Api::Messages} using {#connection}
      # @example Get messages
      #   client.messages.get
      # @return [Api::Messages] the API class
      def messages
        Api::Messages.new @connection
      end

      # Create new {Api::PendingAttachments} using {#connection}
      # @example Add pending attachment
      #   client.pending_attachments.post
      # @return [Api::PendingAttachments] the API class
      def pending_attachments
        Api::PendingAttachments.new @connection
      end

      # Create new {Api::UploadedFiles} using {#connection}
      # @example Delete an uploaded file
      #   client.uploaded_files.delete
      # @return [Api::UploadedFiles] the API class
      def uploaded_files
        Api::UploadedFiles.new @connection
      end

      # Create new {Api::Threads} using {#connection}
      # @example Get threads
      #   client.threads.get
      # @return [Api::Threads] the API class
      def threads
        Api::Threads.new @connection
      end

      # Create new {Api::Topics} using {#connection}
      # @example Get topics
      #   client.topics.get
      # @return [Api::Topics] the API class
      def topics
        Api::Topics.new @connection
      end

      # Create new {Api::GroupMemberships} using {#connection}
      # @example Add a User to a Group
      #   client.group_memberships.post
      # @return [Api::GroupMemberships] the API class
      def group_memberships
        Api::GroupMemberships.new @connection
      end

      # Create new {Api::Groups} using {#connection}
      # @example Get groups for a user
      #   client.groups.for_user
      # @return [Api::Groups] the API class
      def groups
        Api::Groups.new @connection
      end

      # Create new {Api::Users} using {#connection}
      # @example Get users
      #   client.users.get_users
      # @return [Api::Users] the API class
      def users
        Api::Users.new @connection
      end

      # Create new {Api::Relationships} using {#connection}
      # @example Get user relationships
      #   client.relationships.get
      # @return [Api::Relationships] the API class
      def relationships
        Api::Relationships.new @connection
      end

      # Create new {Api::Streams} using {#connection}
      # @example Get notifications
      #   client.streams.notifications
      # @return [Api::Streams] the API class
      def streams
        Api::Streams.new @connection
      end

      # Create new {Api::Suggestions} using {#connection}
      # @example Get suggestions
      #   client.suggestions.get
      # @return [Api::Suggestions] the API class
      def suggestions
        Api::Suggestions.new @connection
      end

      # Create new {Api::Subscriptions} using {#connection}
      # @example Get subscriptions to a user
      #   client.subscriptions.to_user
      # @return [Api::Subscriptions] the API class
      def subscriptions
        Api::Subscriptions.new @connection
      end

      # Create new {Api::Invitations} using {#connection}
      # @example Send an invitation
      #   client.invitations.post
      # @return [Api::Invitations] the API class
      def invitations
        Api::Invitations.new @connection
      end

      # Create new {Api::Search} using {#connection}
      # @example Search Yammer
      #   client.search.get
      # @return [Api::Search] the API class
      def search
        Api::Search.new @connection
      end

      # Create new {Api::Networks} using {#connection}
      # @example Get current Network
      #   client.networks.current
      # @return [Api::Networks] the API class
      def networks
        Api::Networks.new @connection
      end

      # Create new {Api::OpenGraphObjects} using {#connection}
      # @example Get OG objects
      #   client.open_graph_objects.get
      # @return [Api::OpenGraphObjets] the API class
      def open_graph_objects
        Api::OpenGraphObjects.new @connection
      end

      # Create new {Api::SupervisorMode} using {#connection}
      # @example Toggle supervisor mode
      #   client.supervisor_mode.toggle
      # @see https://developer.yammer.com/docs/api-requests
      # @return [Api::SupervisorMode] the API class
      def supervisor_mode
        Api::SupervisorMode.new @connection
      end

      # Create new {Api::Oauth} using {#connection}
      # @example Get OAuth2 tokens
      #   client.oauth.tokens
      # @see https://developer.yammer.com/docs/impersonation
      # @return [Api::Oauth] the API class
      def oauth
        Api::Oauth.new @connection
      end

    end
  end
end
