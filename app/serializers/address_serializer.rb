class AddressSerializer < ActiveModel::Serializer
  attributes :id, :formatted_address, :latitude, :longitude

  def formatted_address
    object.formatted
  end
end
