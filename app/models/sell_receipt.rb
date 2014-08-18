class SellReceipt < ActiveRecord::Base
  belongs_to :person
  belongs_to :product

  validates :product_id,            presence: true
  validates :person_id,             presence: true
  validates :product_title,         presence: true
  validates :product_video_url,     presence: true
  validates :price,                 presence: true, numericality: { only_integer: true,
                                                                    greater_than_or_equal_to: 99
                                                                  }
  validates :on_sale_at,            presence: true
  validates :expires_at,            presence: true
  validates :provider_id,           presence: true
  validates :provider,              presence: true
  validates :card_brand,            presence: true
  validates :card_funding,          presence: true
  validates :card_last_four,        presence: true, numericality: { only_integer: true }
  validates :card_expiration_month, presence: true, numericality: { only_integer: true }
  validates :card_expiration_year,  presence: true, numericality: { only_integer: true }
  validates :pickup_at,             presence: true
  validates :pick_up_address,       presence: true
  validates :pick_up_latitude,      presence: true, numericality: {
    greater_than_or_equal_to: -90,
    less_than_or_equal_to:     90
  }
  validates :pick_up_longitude,     presence: true, numericality: {
    greater_than_or_equal_to: -180,
    less_than_or_equal_to:     180
  }
end
