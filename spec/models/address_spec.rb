require 'rails_helper'

RSpec.describe Address, :type => :model do
  let(:address) { FactoryGirl.build(:address) }

  describe 'associations' do
    it { should belong_to(:person) }
  end

  describe "validations" do
    it { should validate_presence_of :person_id }
    it { should validate_presence_of :street1 }
    it { should validate_presence_of :city }
    it { should validate_presence_of :region }
    it { should validate_presence_of :postal_code }
    it { should validate_presence_of :country }
    it { should validate_numericality_of(:latitude).is_less_than_or_equal_to(90) }
    it { should validate_numericality_of(:latitude).is_greater_than_or_equal_to(-90) }
    it { should validate_numericality_of(:longitude).is_less_than_or_equal_to(180) }
    it { should validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180) }
  end
end
