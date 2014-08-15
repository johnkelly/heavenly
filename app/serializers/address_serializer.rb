class AddressSerializer < ActiveModel::Serializer
  attributes :id, :formatted_address, :latitude, :longitude

  def formatted_address
    if object.street2.present?
      "#{object.street1}\n#{object.street2}\n#{object.city}, #{object.region}, #{object.postal_code}"
    else
      "#{object.street1}\n#{object.city}, #{object.region}, #{object.postal_code}"
    end
  end
end
