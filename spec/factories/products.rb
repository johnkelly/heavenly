# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    seller_id "6dd3d63f-7fce-4598-acd6-6fdd568a294c"
    title "MyString"
    description "MyText"
    video_url "MyString"
    price 1
    on_sale false
    on_sale_at "2014-08-15 20:09:59"
    expired false
    expires_at "2014-08-15 20:09:59"
    sold false
    sold_at "2014-08-15 20:09:59"
    buyer_id ""
  end
end
