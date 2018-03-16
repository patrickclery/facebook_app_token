require "spec_helper"

RSpec.describe FacebookAppToken do
  it "has a version number" do
    expect(FacebookAppToken::VERSION).not_to be nil
  end

  describe '#self.fetch_token' do
    it 'should raise FacebookAuthenticationError if wrong email or password given' do
      app_id = ENV['FACEBOOK_APP_ID'] || raise('You have to set an environment variable with FACEBOOK_APP_ID before execute this test')
      expect { FacebookAppToken.fetch_token('wrong email', 'wrong_password', app_id) }.to raise_error(FacebookAppToken::FacebookAuthenticationError, 'Facebook Authentication failed. Check if you passed correct email and password')
    end

    it 'should raise FacebookAuthenticationError if invalid app id specified' do
      email = ENV['FACEBOOK_AUTH_EMAIL'] || raise('You have to set an environment variable with FACEBOOK_AUTH_EMAIL before execute this test')
      password = ENV['FACEBOOK_AUTH_PASSWORD'] || raise('You have to set an environment variable with FACEBOOK_AUTH_PASSWORD before execute this test')

      expect { FacebookAppToken.fetch_token(email, password, 'invalid app id') }.to raise_error(FacebookAppToken::FacebookAuthenticationError, 'Facebook Authentication failed. Invalid App ID specified')
    end


    # You have to set environment variables FACEBOOK_AUTH_EMAIL, FACEBOOK_AUTH_PASSWORD with your valid Facebook email address and password
    #
    # ex:
    #
    # ~/.bashrc
    # export FACEBOOK_AUTH_EMAIL="your_facebook_email@gmail.com"
    # export FACEBOOK_AUTH_PASSWORD="your_facebook_password"
    # export FACEBOOK_AUTH_APP_ID="your_facebook_app_id"   (use 464891386855067 for tinder)

    it 'should fetch a correct token' do
      email = ENV['FACEBOOK_AUTH_EMAIL'] || raise('You have to set an environment variable with FACEBOOK_AUTH_EMAIL before execute this test')
      password = ENV['FACEBOOK_AUTH_PASSWORD'] || raise('You have to set an environment variable with FACEBOOK_AUTH_PASSWORD before execute this test')
      app_id = ENV['FACEBOOK_APP_ID'] || raise('You have to set an environment variable with FACEBOOK_APP_ID before execute this test')

      token = FacebookAppToken.fetch_token(email, password, app_id)
      expect(token.length).not_to eq(0)
    end
  end
end
