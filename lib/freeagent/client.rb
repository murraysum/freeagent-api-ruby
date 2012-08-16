require 'oauth2'
require 'multi_json'

module FreeAgent
  class Client
    def initialize(client_id, client_secret)
      if client_id && client_secret
        @client_id = client_id
        @client_secret = client_secret
        @client = OAuth2::Client.new(@client_id, @client_secret, Client.client_options)
      else
        raise FreeAgent::ClientError.new('Client id or client secret not set')
      end
    end

    def self.client_options
      {
        :site => Client.site,
        :authorize_url => Client.authorize_url,
        :token_url => Client.token_url,
        :connection_opts => Client.connection_opts
      }
    end

    def self.site
      sites[ FreeAgent.environment || :production ]
    end

    def self.sites
      { :sandbox => 'https://api.sandbox.freeagent.com/v2/', :production => 'https://api.freeagent.com/v2/' }
    end

    def self.authorize_url
      'approve_app'
    end

    def self.token_url
      'token_endpoint'
    end

    def self.connection_opts
      { :headers => { :user_agent => "freeagent-api-rb", :accept => "application/json", :content_type => "application/json" } }
    end
    
    def fetch_access_token(auth_code, options)
      if options[:redirect_uri]
        @access_token = @client.auth_code.get_token(auth_code, options)
      else
        raise FreeAgent::ClientError.new('Redirect uri not specified')
      end
    end

    def access_token
      @access_token
    end

    def access_token=(token)
      @access_token = OAuth2::AccessToken.new(@client, token)
    end

    def get(path, params={})
      request(:get, "#{Client.site}#{path}", :params => params).parsed
    end

    def post(path, data={})
      request(:post, "#{Client.site}#{path}", :data => data).parsed
    end

    def put(path, data={})
      request(:put, "#{Client.site}#{path}", :data => data).parsed
    end

    def delete(path, data={})
      request(:delete, "#{Client.site}#{path}", :data => data).parsed
    end

  private

    def request(method, path, options = {})
      if @access_token
        options[:body] = MultiJson.encode(options[:data]) unless options[:data].nil?
        @access_token.send(method, path, options)
      else
        raise FreeAgent::ClientError.new('Access Token not set')
      end
    rescue OAuth2::Error => error
      api_error = FreeAgent::ApiError.new(error.response)
      puts api_error if FreeAgent.debug
      raise api_error
    end
  end
end
