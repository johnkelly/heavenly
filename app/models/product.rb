class Product < ActiveRecord::Base
  belongs_to :seller, foreign_key: :seller_id,  class_name: 'Person'
  belongs_to :buyer,  foreign_key: :buyer_id,   class_name: 'Person'

  has_many :questions,      dependent: :destroy
  has_many :sell_receipts,  dependent: :destroy

  validates :seller_id, presence: true
  validates :title,     presence: true
  validates :video_url, presence: true
  validates :price,     presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 99 }
  validates :on_sale,   inclusion: [true, false]
  validates :expired,   inclusion: [true, false]
  validates :sold,      inclusion: [true, false]

  scope :sold,          -> { where(sold: true) }
  scope :unsold,        -> { where(sold: false) }
  scope :expired,       -> { where(expired: true) }
  scope :fresh,         -> { where(expired: false) }
  scope :on_sale,       -> { where(on_sale: true) }
  scope :off_sale,      -> { where(on_sale: false) }
  scope :search_import, -> { includes(:questions, seller: [:facebook, :address], buyer: [:facebook, :address]) }

  searchkick locations: ['location'], callbacks: false

  after_commit :reindex_async

  def self.search_within_ten_miles(latitude, longitude, term = '*')
    Product.search term,
                   fields: [:title, :description],
                   track: {
                     query: "#{term} 10 miles of #{latitude.round(2)}, #{longitude.round(2)}"
                   },
                   where: {
                     location: { near: [latitude, longitude], within: '10mi' },
                     sold: false,
                     expired: false,
                     on_sale: true
                   }
  rescue Searchkick::InvalidQueryError
    []
  end

  def search_data
    ProductSerializer.new(self).serializable_hash
  end

  private

  def reindex_async
    ReindexWorker.perform_async(id, Product.to_s)
  end
end
