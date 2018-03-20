require 'facebook_app_token/version'
require 'mechanize'

module FacebookAppToken
  USER_AGENT = 'Mozilla/5.0 (Linux; U; en-gb; KFTHWI Build/JDQ39) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.16 Safari/535.19'

  class FacebookAuthenticationError < StandardError; end

  def self.login_uri(app_id)
    "https://m.facebook.com/v2.10/dialog/oauth?client_id=#{URI::encode(app_id.to_s)}&scope=public_profile%2Cuser_education_history%2Cuser_friends%2Cemail%2Cuser_likes%2Cuser_photos%2Cuser_relationships%2Cuser_work_history%2Cuser_birthday&default_audience=friends&redirect_uri=fbconnect%3A%2F%2Fsuccess&auth_type=rerequest&display=touch&response_type=token%2Csigned_request&return_scopes=true"
  end

  def self.fetch_token(email, password, app_id)
    # Login to the page
    logged_in = login(email, password, app_id)

    # Click OK
    confirmed = confirm(logged_in)

    # Retrieve token
    confirmed.content.match(/access_token=(\w+)&expires_in=/)[1]
  end

  def self.prepare_agent
    agent = Mechanize.new
    agent.user_agent = USER_AGENT
    agent
  end

  def self.login(email, password, app_id)
    agent = prepare_agent
    uri = self.login_uri(app_id)
    page = agent.get(uri)

    if page.title == 'Error'
      raise FacebookAppToken::FacebookAuthenticationError, 'Facebook Authentication failed. Invalid App ID specified'
    end

    f = page.forms[0]
    f.field_with(name: 'email').value = email
    f.field_with(name: 'pass').value = password

    res = agent.submit f

    if res.uri.path.start_with? '/login'
      raise FacebookAppToken::FacebookAuthenticationError, 'Facebook Authentication failed. Check if you passed correct email and password'
    end

    res
  end

  def self.confirm(logged_in)
    confirm = logged_in.forms[0]
    confirm.click_button(confirm.button_with(name: '__CONFIRM__'))
  end

  private_class_method :prepare_agent, :login, :confirm
end
