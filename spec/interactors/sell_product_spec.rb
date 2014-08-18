require 'spec_helper'

RSpec.describe SellProduct do
  let(:interactor) { SellProduct.new }

  describe 'Organizer' do
    before do
      allow(CheckIfSellable).to receive(:perform)
      allow(PutProductOnSale).to receive(:perform)
      allow(GenerateSellReceipt).to receive(:perform)
      interactor.perform
    end
    it { expect(CheckIfSellable).to have_received(:perform) }
    it { expect(PutProductOnSale).to have_received(:perform) }
    it { expect(GenerateSellReceipt).to have_received(:perform) }
  end
end
