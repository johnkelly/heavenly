class FacebookSignUp
  include Interactor

  def perform
    assert_correct_facebook_info unless failure?
    return if failure?

    person = build_person_from_facebook

    if person.save
      person.facebook.exchange_access_token(token)
      context[:person] = person
    else
      errors = person.errors.full_messages
      fail!(errors: errors)
    end
  end

  def setup
    fail!(errors: ['Missing Facebook access token']) unless context[:token].present?
  end

  def build_person_from_facebook
    person = Person.new(auth_token: Person.generate_authentication_token,
                        email:      facebook_info['email'],
                        first_name: facebook_info['first_name'],
                        last_name:  facebook_info['last_name'],
                        gender:     facebook_info['gender'],
                        locale:     facebook_info['locale'])

    person.build_facebook(provider_person_id: facebook_info['id'],
                          token:            token,
                          expiration:       1.hour.from_now,
                          link:             facebook_info['link'],
                          verified:         facebook_info['verified'])
    person
  end

  def assert_correct_facebook_info
    return unless facebook_info.present?
    facebook_attributes = %w(email id first_name last_name gender link locale)
    facebook_attributes.each do |attribute|
      if facebook_info[attribute].blank?
        fail!(errors: ["Facebook #{attribute.humanize.downcase} is required."])
        break
      end
    end
    fail!(errors: ['Facebook verified is required.']) if facebook_info['verified'].nil?
  end

  # Facebook Information
  #
  # {
  #   id: "1521070431458816"
  #   email: "open_iqtpqqa_@tfbnw.net"
  #   first_name: "Open"
  #   gender: "female"
  #   last_name: "Kelly"
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
