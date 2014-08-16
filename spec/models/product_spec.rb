require 'rails_helper'

RSpec.describe Product, :type => :model do
  let(:product) { FactoryGirl.build(:product) }

  describe 'associations' do
    it { should belong_to(:seller).with_foreign_key('seller_id').class_name('Person') }
    it { should belong_to(:buyer).with_foreign_key('buyer_id').class_name('Person') }
  end

  describe "validations" do
    it { should validate_presence_of :seller_id }
    it { should validate_presence_of :title }
    it { should validate_presence_of :video_url }
    it { should validate_presence_of :price }
    it { should validate_presence_of :on_sale }
    it { should validate_presence_of :expired }
    it { should validate_presence_of :sold }
    it { should validate_numericality_of(:price).only_integer }
  end
end
