FactoryGirl.define do
  factory :auth_provider do
    type ''
    person_id 'fake-id'
    provider_person_id 'MyString'
    token 'MyString'
    expiration '2014-08-05 21:34:25'
    link 'MyString'
    verified 'false'
  end

  factory :facebook do
    type 'Facebook'
    person_id 'fake-id'
    provider_person_id 'MyString'
    token 'MyString'
    expiration '2014-08-05 21:34:25'
    link 'MyString'
    verified 'false'
  end
end
