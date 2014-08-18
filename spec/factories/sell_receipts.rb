# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sell_receipt do
    product_id ""
    person_id ""
    product_title "MyString"
    product_video_url "MyString"
    product_description "MyText"
    price 1
    on_sale_at "2014-08-17 15:23:00"
    expires_at "2014-08-17 15:23:00"
    provider_id "FakeStripe"
    provider "Stripe"
    card_brand "MyString"
    card_funding "MyString"
    card_last_four 1
    card_expiration_month 1
    card_expiration_year 1
    pickup_at "2014-08-17 15:23:00"
    pick_up_address "MyText"
    pick_up_latitude "9.99"
    pick_up_longitude "9.99"
  end
end
