class Account < ActiveRecord::Base
  validates :type,                  presence: true
  validates :person_id,             presence: true
  validates :provider_id,           presence: true
  validates :provider,              presence: true
  validates :card_brand,            presence: true
  validates :card_funding,          presence: true
  validates :card_last_four,        presence: true, numericality: { only_integer: true }
  validates :card_expiration_month, presence: true, numericality: { only_integer: true }
  validates :card_expiration_year,  presence: true, numericality: { only_integer: true }

  PROVIDER = 'Stripe'
end
