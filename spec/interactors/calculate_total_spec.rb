require 'rails_helper'

RSpec.describe CalculateTotal do
  let(:product) { FactoryGirl.build_stubbed_uuid(:product) }
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:interactor) { CalculateTotal.new({person: person, deliver_at: Time.now, product: product}) }

  before do
    allow(interactor).to receive(:apply_any_discount)
    allow(interactor).to receive(:calculate_sales_tax)
    allow(interactor).to receive(:calculate_sub_total)
    allow(interactor).to receive(:calculate_shipping)
    allow(interactor).to receive(:calculate_total)
    interactor.perform
  end
  it { expect(interactor).to have_received(:apply_any_discount) }
  it { expect(interactor).to have_received(:calculate_sales_tax) }
  it { expect(interactor).to have_received(:calculate_sub_total) }
  it { expect(interactor).to have_received(:calculate_shipping) }
  it { expect(interactor).to have_received(:calculate_total) }
end
