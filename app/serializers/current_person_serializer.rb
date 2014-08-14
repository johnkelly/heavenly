class CurrentPersonSerializer < ActiveModel::Serializer
  attributes :id, :auth_token, :first_name, :last_name,
             :gender, :locale, :profile_picture

  def profile_picture
    "https://graph.facebook.com/#{object.facebook.provider_person_id}/picture"
  end
end
