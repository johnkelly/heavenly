class Product < ActiveRecord::Base
  belongs_to :seller, foreign_key: :seller_id,  class_name: 'Person'
  belongs_to :buyer,  foreign_key: :buyer_id,   class_name: 'Person'

  validates :seller_id, presence: true
  validates :title,     presence: true
  validates :video_url, presence: true
  validates :price,     presence: true, numericality: { only_integer: true }
  validates :on_sale,   presence: true
  validates :expired,   presence: true
  validates :sold,      presence: true

  scope :sold,      -> { where(sold: true) }
  scope :unsold,    -> { where(sold: false) }
  scope :expired,   -> { where(expired: true) }
  scope :fresh,     -> { where(expired: false) }
  scope :on_sale,   -> { where(on_sale: true) }
  scope :off_sale,  -> { where(on_sale: false) }
end
