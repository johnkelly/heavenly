class Product < ActiveRecord::Base
  belongs_to :seller, foreign_key: :seller_id,  class_name: 'Person'
  belongs_to :buyer,  foreign_key: :buyer_id,   class_name: 'Person'

  validates :seller_id, presence: true
  validates :title,     presence: true
  validates :video_url, presence: true
  validates :price,     presence: true, numericality: { only_integer: true }
  validates :on_sale,   inclusion: [true, false]
  validates :expired,   inclusion: [true, false]
  validates :sold,      inclusion: [true, false]

  scope :sold,      -> { where(sold: true) }
  scope :unsold,    -> { where(sold: false) }
  scope :expired,   -> { where(expired: true) }
  scope :fresh,     -> { where(expired: false) }
  scope :on_sale,   -> { where(on_sale: true) }
  scope :off_sale,  -> { where(on_sale: false) }

  searchkick locations: ['location']

  def self.search_within_ten_miles(latitude, longitude, term = '*')
    Product.search term, where: { location: { near: [latitude, longitude], within: '10mi' } }
  end

  def search_data
    ProductSerializer.new(self).serializable_hash
  end
end
