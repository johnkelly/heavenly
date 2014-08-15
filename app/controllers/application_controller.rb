class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :null_session, if: proc { |c| c.request.format == 'application/json' }

  before_action :authenticate

  attr_reader :current_person
  helper_method :current_person

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      id = options[:id].presence
      person = id && Person.where(id: id).first

      if person && Person.secure_compare(person.auth_token, token)
        @current_person = person
      end
    end
  rescue
    head :unauthorized
  end
end
