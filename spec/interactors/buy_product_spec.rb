require 'spec_helper'

RSpec.describe BuyProduct do
  let(:interactor) { BuyProduct.new }

  describe 'Organizer' do
    before do
      allow(CheckIfBuyable).to receive(:perform)
      allow(CalculateTotal).to receive(:perform)
      allow(AuthorizeCreditCard).to receive(:perform)
      allow(GenerateBuyReceipt).to receive(:perform)
      allow(GenerateOrder).to receive(:perform)
      allow(MarkProductAsSold).to receive(:perform)
      interactor.perform
    end
    it { expect(CheckIfBuyable).to have_received(:perform) }
    it { expect(CalculateTotal).to have_received(:perform) }
    it { expect(AuthorizeCreditCard).to have_received(:perform) }
    it { expect(GenerateBuyReceipt).to have_received(:perform) }
    it { expect(GenerateOrder).to have_received(:perform) }
    it { expect(MarkProductAsSold).to have_received(:perform) }
  end
end
