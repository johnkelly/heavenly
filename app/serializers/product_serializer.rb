class ProductSerializer < ActiveModel::Serializer
  attributes :id, :location, :seller, :title, :description,
             :video_url, :price, :on_sale, :on_sale_at, :expired,
             :expires_at, :sold, :sold_at, :buyer, :created_at, :updated_at

  def location
    [object.seller.address.latitude, object.seller.address.longitude]
  end

  def seller
    PersonSerializer.new(object.seller)
  end

  def buyer
    PersonSerializer.new(object.buyer) if object.buyer.present?
  end
end
