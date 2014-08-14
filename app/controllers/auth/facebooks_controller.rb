module Auth
  class FacebooksController < ApplicationController
    skip_before_action :authenticate

    def create
      @result = if new_person?
                  FacebookSignUp.perform(token: token_param)
                else
                  FacebookSignIn.perform(token: token_param)
                end

      if @result.success?
        render json: @result.person, serializer: CurrentPersonSerializer, status: :ok
      else
        render json: { errors: @result.errors }, status: :unprocessable_entity
      end
    end

    private

    def token_param
      params.require(:facebook).require(:token)
    end

    def new_person?
      facebook_json = Facebook.person_json(token_param)
      facebook_person_id = facebook_json.fetch('id') do
        fail 'Missing Facebook id from Facebook person_json call'
      end
      Facebook.where(provider_person_id: facebook_person_id).count == 0
    end
  end
end
