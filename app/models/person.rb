class Person < ActiveRecord::Base
  has_one :facebook, dependent: :destroy
  has_one :buyer,    dependent: :destroy
  has_one :seller,   dependent: :destroy
  has_one :address,  dependent: :destroy

  has_many :sold_products,      dependent: :destroy, class_name: 'Product',   foreign_key: :seller_id
  has_many :purchased_products, dependent: :destroy, class_name: 'Product',   foreign_key: :buyer_id
  has_many :questions,          dependent: :destroy, class_name: 'Question',  foreign_key: :asker_id
  has_many :answers,            dependent: :destroy, class_name: 'Question',  foreign_key: :replier_id
  has_many :sell_receipts,      dependent: :destroy

  validates :auth_token,  presence: true, uniqueness: true
  validates :email,       presence: true
  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :gender,      presence: true
  validates :locale,      presence: true

  include Authentication

  after_commit :reindex_async

  private

  def reindex_async
    ReindexPersonProductsWorker.perform_async(id)
  end
end
