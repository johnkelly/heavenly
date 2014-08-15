FactoryGirl.define do
  factory :account do
    type ''
    person_id 'fakepersonid'
    provider_id 'stripeid'
    provider 'Stripe'
    card_brand 'Visa'
    card_funding 'Credit'
    card_last_four 3434
    card_expiration_month 1
    card_expiration_year 2017
  end

  factory :buyer do
    type 'Buyer'
    person_id 'fakepersonid'
    provider_id 'stripeid'
    provider 'Stripe'
    card_brand 'Visa'
    card_funding 'Credit'
    card_last_four 3434
    card_expiration_month 1
    card_expiration_year 2017
  end

  factory :seller do
    type 'Seller'
    person_id 'fakepersonid'
    provider_id 'stripeid'
    provider 'Stripe'
    card_brand 'Visa'
    card_funding 'Debit'
    card_last_four 3434
    card_expiration_month 1
    card_expiration_year 2017
  end
end
