require 'rails_helper'

RSpec.describe GenerateSellReceipt do
  let(:product) { FactoryGirl.build_stubbed_uuid(:product) }
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:address) { FactoryGirl.build_stubbed_uuid(:address) }
  let(:seller) { FactoryGirl.build_stubbed_uuid(:seller) }
  let(:interactor) { GenerateSellReceipt.new({person: person, pickup_at: Time.now, product: product}) }

  before do
    allow(person).to receive(:seller).and_return(seller)
    allow(person).to receive(:address).and_return(address)
    allow(SellReceipt).to receive(:create!)
    interactor.perform
  end
  it { expect(SellReceipt).to have_received(:create!) }
end
