require 'rails_helper'

RSpec.describe CheckIfBuyable do
  let(:product) { FactoryGirl.build_stubbed_uuid(:product) }
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:interactor) { CheckIfBuyable.new({person: person, deliver_at: Time.now, product: product}) }

  before do
    allow(interactor).to receive(:assert_person_is_a_buyer)
    allow(interactor).to receive(:assert_valid_deliver_at)
    allow(interactor).to receive(:assert_product_is_buyable)
    interactor.perform
  end
  it { expect(interactor).to have_received(:assert_person_is_a_buyer) }
  it { expect(interactor).to have_received(:assert_valid_deliver_at) }
  it { expect(interactor).to have_received(:assert_product_is_buyable) }
end
