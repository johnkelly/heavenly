require 'rails_helper'

RSpec.describe Product, :type => :model do
  let(:product) { FactoryGirl.build(:product) }

  describe 'associations' do
    it { should belong_to(:seller).with_foreign_key('seller_id').class_name('Person') }
    it { should belong_to(:buyer).with_foreign_key('buyer_id').class_name('Person') }
    it { should have_many(:sell_receipts).dependent(:destroy) }
    it { should have_many(:questions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of :seller_id }
    it { should validate_presence_of :title }
    it { should validate_presence_of :video_url }
    it { should validate_presence_of :price }
    # it { should validate_inclusion_of(:on_sale).in_array([true, false]) }
    # it { should validate_inclusion_of(:expired).in_array([true, false]) }
    # it { should validate_inclusion_of(:sold).in_array([true, false]) }
    it { should validate_numericality_of(:price).only_integer }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(99) }
  end

  describe 'self.search_within_ten_miles' do
    before do
      allow(Product).to receive(:search)
      Product.search_within_ten_miles(37, -122)
    end
    it { expect(Product).to have_received(:search) }
  end

  describe 'search_data' do
    before do
      allow(ProductSerializer).to receive(:new).and_return(product)
      allow(product).to receive(:serializable_hash)
      product.search_data
    end
    it { expect(ProductSerializer).to have_received(:new) }
    it { expect(product).to have_received(:serializable_hash) }
  end
end
