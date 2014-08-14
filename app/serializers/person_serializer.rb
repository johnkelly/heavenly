class PersonSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name,
             :gender, :locale, :profile_picture

  def profile_picture
    "https://graph.facebook.com/#{object.facebook.provider_person_id}/picture"
  end
end
