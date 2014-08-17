# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    product_id ""
    question "MyText"
    asker_id ""
    answer "MyText"
    replier_id ""
  end
end
