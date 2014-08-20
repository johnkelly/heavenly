require 'rails_helper'

RSpec.describe MarkProductAsSold do
  let(:product) { FactoryGirl.build_stubbed_uuid(:product) }
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:interactor) { MarkProductAsSold.new({person: person, product: product}) }

  before do
    allow(product).to receive(:update!)
    interactor.perform
  end
  it { expect(product).to have_received(:update!) }
end
