require 'rails_helper'

RSpec.describe Account, :type => :model do
  let(:account) { FactoryGirl.build(:account) }

  describe "validations" do
    it { should validate_presence_of :type }
    it { should validate_presence_of :person_id }
    it { should validate_presence_of :provider_id }
    it { should validate_presence_of :provider }
    it { should validate_presence_of :card_brand }
    it { should validate_presence_of :card_funding }
    it { should validate_presence_of :card_last_four }
    it { should validate_presence_of :card_expiration_month }
    it { should validate_presence_of :card_expiration_year }
    it { should validate_numericality_of(:card_last_four).only_integer }
    it { should validate_numericality_of(:card_expiration_month).only_integer }
    it { should validate_numericality_of(:card_expiration_year).only_integer }
  end
end
