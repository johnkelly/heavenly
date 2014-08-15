# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street1 "MyString"
    street2 "MyString"
    city "MyString"
    region "MyString"
    postal_code "MyString"
    country "MyString"
    latitude "9.99"
    longitude "9.99"
  end
end
