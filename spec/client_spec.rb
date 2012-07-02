require_relative 'spec_helper'

describe FreeAgent::Client do

  describe 'initialize' do
    #TODO
    it 'should create a new client instance with client id and secret' do
      @client = FreeAgent::Client.new('id', 'secret')
    end

    it 'should raise client error when no client id or secret specified' do
      expect { FreeAgent::Client.new(nil, '') }.should raise_error(FreeAgent::ClientError)
      expect { FreeAgent::Client.new('', nil) }.should raise_error(FreeAgent::ClientError)
      expect { FreeAgent::Client.new(nil, nil) }.should raise_error(FreeAgent::ClientError)
    end
  end

  describe 'client_options' do
    before :each do
      @client_options = FreeAgent::Client.client_options
    end

    it 'should have the site' do
      @client_options.should have_key(:site)
      @client_options[:site].should_not be_nil
    end

    it 'should have the authorize url' do
      @client_options.should have_key(:authorize_url)
      @client_options[:authorize_url].should_not be_nil
    end

    it 'should have the token url' do
      @client_options.should have_key(:token_url)
      @client_options[:token_url].should_not be_nil
    end

    it 'should have the connection opts' do
      @client_options.should have_key(:connection_opts)
      @client_options[:connection_opts].should_not be_nil
    end
  end

  describe 'site' do
    it 'should by default return the production url' do
      FreeAgent::Client.site.should eql 'https://api.freeagent.com/v2/'
    end

    it 'should return sandbox url when specified' do
      FreeAgent.environment = :sandbox
      FreeAgent::Client.site.should eql 'https://api.sandbox.freeagent.com/v2/'
    end

    it 'should return production url when specified' do
      FreeAgent.environment = :production
      FreeAgent::Client.site.should eql 'https://api.freeagent.com/v2/'
    end
  end

  describe 'sites' do
    before :each do
      @sites = FreeAgent::Client.sites
    end

    it 'should have the production url' do
      @sites.should have_key(:production)
      @sites[:production].should eql 'https://api.freeagent.com/v2/'
    end

    it 'should have the sandbox url' do
      @sites.should have_key(:sandbox)
      @sites[:sandbox].should eql 'https://api.sandbox.freeagent.com/v2/'
    end
  end

  describe 'authorize_url' do
    it 'should return the authorize url for the oauth client' do
      FreeAgent::Client.authorize_url.should eql 'approve_app'
    end
  end

  describe 'token_url' do
    it 'should return the token url for the oauth client' do
      FreeAgent::Client.token_url.should eql 'token_endpoint'
    end
  end

  describe 'connection_opts' do
    before(:each) do
      @headers = FreeAgent::Client.connection_opts[:headers]
    end

    it 'should have freeagent-api-rb user agent' do
      @headers.should have_key(:user_agent)
      @headers[:user_agent].should eql 'freeagent-api-rb'
    end

    it 'should have json accept header' do
      @headers.should have_key(:accept)
      @headers[:accept].should eql 'application/json'
    end
  end


  describe '#fetch access_token' do
    before :each do
      @client = FreeAgent::Client.new('id', 'secret')
    end

    it 'should fetch access token' do
      #access_token = @client.fetch_access_token('auth_code', :redirect_uri => '')
      # TODO
    end

    it 'should raise client error when redirect not specified' do
      fetch_access_token = expect {@client.fetch_access_token('auth_code', {})}
      fetch_access_token.should raise_error(FreeAgent::ClientError)
    end
  end

  describe '#access_token and #access_token=' do
    before :each do
      @client = FreeAgent::Client.new('id', 'secret')
    end

    it 'should set and get the access token' do
      @client.access_token = 'token'
      @client.access_token.token.should eql 'token'
    end

    it 'should have nil access token as it has not been set' do
      @client.access_token.should be_nil
    end
  end

  describe '#get' do
    # TODO
  end

  describe '#post' do
    # TODO
  end

  describe '#put' do
    # TODO
  end

  describe '#delete' do
    # TODO
  end
end
