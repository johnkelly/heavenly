require 'rails_helper'

RSpec.describe CheckIfSellable do
  let(:product) { FactoryGirl.build_stubbed_uuid(:product) }
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:interactor) { CheckIfSellable.new({person: person, pickup_at: Time.now, product: product}) }

  before do
    allow(interactor).to receive(:assert_person_is_a_seller)
    allow(interactor).to receive(:assert_valid_pickup_at)
    allow(interactor).to receive(:assert_product_is_sellable)
    interactor.perform
  end
  it { expect(interactor).to have_received(:assert_person_is_a_seller) }
  it { expect(interactor).to have_received(:assert_valid_pickup_at) }
  it { expect(interactor).to have_received(:assert_product_is_sellable) }
end
