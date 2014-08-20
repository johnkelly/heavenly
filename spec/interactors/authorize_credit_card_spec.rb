require 'rails_helper'

RSpec.describe AuthorizeCreditCard do
  let(:product) { FactoryGirl.build_stubbed_uuid(:product) }
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:interactor) { AuthorizeCreditCard.new(person: person, total: 300, product: product) }

  before do
    allow(interactor).to receive(:customer)
    allow(Stripe::Charge).to receive(:create)
    interactor.perform
  end
  it { expect(interactor).to have_received(:customer) }
  it { expect(Stripe::Charge).to have_received(:create) }
end
