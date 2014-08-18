require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:person) { FactoryGirl.build(:person) }

  describe 'associations' do
    it { should have_one(:facebook).dependent(:destroy) }
    it { should have_one(:buyer).dependent(:destroy) }
    it { should have_one(:seller).dependent(:destroy) }
    it { should have_one(:address).dependent(:destroy) }

    it do
      should have_many(:sold_products)
        .dependent(:destroy)
        .class_name('Product')
        .with_foreign_key('seller_id')
    end
    it do
      should have_many(:purchased_products)
        .dependent(:destroy)
        .class_name('Product')
        .with_foreign_key('buyer_id')
    end
  end
  it do
    should have_many(:questions)
      .dependent(:destroy)
      .class_name('Question')
      .with_foreign_key('asker_id')
  end
  it do
    should have_many(:answers)
      .dependent(:destroy)
      .class_name('Question')
      .with_foreign_key('replier_id')
  end
  it { should have_many(:sell_receipts).dependent(:destroy) }

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :auth_token }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :gender }
    it { should validate_presence_of :locale }
    # it { should validate_uniqueness_of :auth_token }
  end

  it_behaves_like 'has authentication concerns', Person
end
