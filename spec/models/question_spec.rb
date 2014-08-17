require 'rails_helper'

RSpec.describe Question, :type => :model do
  let(:question) { FactoryGirl.build(:question) }

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:asker).with_foreign_key('asker_id').class_name('Person') }
    it { should belong_to(:replier).with_foreign_key('replier_id').class_name('Person') }
  end

  describe 'validations' do
    it { should validate_presence_of :product_id }
    it { should validate_presence_of :question }
    it { should validate_presence_of :asker_id }
  end
end
