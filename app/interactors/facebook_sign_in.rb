class FacebookSignIn
  include Interactor

  def perform
    return if failure?
    facebook_person_id = facebook_info.fetch('id')

    facebook = Facebook.where(provider_person_id: facebook_person_id).first
    facebook.exchange_access_token(token)
    facebook.person.update!(auth_token: Person.generate_authentication_token)
    context[:person] = facebook.person
  end

  def setup
    fail!(errors: ['Missing Facebook access token']) unless context[:token].present?
  end

  # Facebook Information
  #
  # {
  #   id: "1521070431458816"
  #   email: "open_iqtpqqa_user@tfbnw.net"
  #   first_name: "Open"
  #   gender: "female"
  #   last_name: "User"
  #   link: "https://www.facebook.com/app_scoped_user_id/1521070431458816/"
  #   locale: "en_US"
  #   middle_name: "Graph Test"
  #   name: "Open Graph Test User"
  #   timezone: -7
  #   updated_time: "2014-08-04T06:25:05+0000"
  #   verified: false
  # }

  def facebook_info
    @facebook_info ||= Facebook.person_json(token)
  rescue Koala::Facebook::AuthenticationError
    Rails.logger.info "Invalid or Expired Facebook Access Token #{token}"
    fail!(errors: ["Invalid or Expired Facebook Access Token #{token}"])
    {}
  end
end
