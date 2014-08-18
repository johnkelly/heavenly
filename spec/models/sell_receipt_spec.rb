require 'rails_helper'

RSpec.describe SellReceipt, :type => :model do
  let(:sell_receipt) { FactoryGirl.build(:sell_receipt) }

  describe 'associations' do
    it { should belong_to(:person) }
    it { should belong_to(:product) }
  end

  describe "validations" do
    it { should validate_presence_of :product_id }
    it { should validate_presence_of :person_id }
    it { should validate_presence_of :product_title }
    it { should validate_presence_of :product_video_url }
    it { should validate_presence_of :price }
    it { should validate_presence_of :on_sale_at }
    it { should validate_presence_of :expires_at }
    it { should validate_presence_of :provider_id }
    it { should validate_presence_of :provider }
    it { should validate_presence_of :card_brand }
    it { should validate_presence_of :card_funding }
    it { should validate_presence_of :card_last_four }
    it { should validate_presence_of :card_expiration_month }
    it { should validate_presence_of :card_expiration_year }
    it { should validate_presence_of :pickup_at }
    it { should validate_presence_of :pick_up_address }
    it { should validate_presence_of :pick_up_latitude }
    it { should validate_presence_of :pick_up_longitude }
    it { should validate_numericality_of(:price).only_integer }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(99) }
    it { should validate_numericality_of(:card_last_four).only_integer }
    it { should validate_numericality_of(:card_expiration_month).only_integer }
    it { should validate_numericality_of(:card_expiration_year).only_integer }
    it { should validate_numericality_of(:pick_up_latitude).is_less_than_or_equal_to(90) }
    it { should validate_numericality_of(:pick_up_latitude).is_greater_than_or_equal_to(-90) }
    it { should validate_numericality_of(:pick_up_longitude).is_less_than_or_equal_to(180) }
    it { should validate_numericality_of(:pick_up_longitude).is_greater_than_or_equal_to(-180) }
  end
end
