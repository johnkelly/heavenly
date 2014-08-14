class Facebook < AuthProvider
  belongs_to :person

  def self.person_json(token)
    graph = Koala::Facebook::API.new(token)
    graph.get_object('me', {})
  end

  def exchange_access_token(old_access_token)
    new_token_info = oauth.exchange_access_token_info(old_access_token)
    new_token = new_token_info.fetch('access_token') do
      fail 'FB exchange access token api missing token'
    end
    update!(token: new_token, expiration: expiration_time(new_token_info))
  end

  private

  def oauth
    @oauth ||= Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
  end

  def expiration_time(new_token_info)
    seconds_to_expiration = new_token_info.fetch('expires') do
      fail 'FB exchange access token api missing expiration seconds'
    end
    days_to_expiration = Integer(seconds_to_expiration) / 1.day
    days_to_expiration.floor.days.from_now
  end
end
