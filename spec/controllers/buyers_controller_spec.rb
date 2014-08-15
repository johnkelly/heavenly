require 'rails_helper'

RSpec.describe BuyersController, type: :controller do
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:result) { Interactor::Context.build }

  before do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_person).and_return(person)
  end

  describe 'POST #create' do
    context 'success' do
      before do
        allow(CreateBuyerAccount).to receive(:perform).and_return(result)
        allow(result).to receive(:success?).and_return(true)
        allow(result).to receive(:buyer_account)
        post :create, new_buyer: { token: 'faketoken', card_last_four: '4242', card_type: 'Visa' }
      end
      it { should respond_with(:created) }
      it { expect(CreateBuyerAccount).to have_received(:perform) }
      it { expect(result).to have_received(:success?) }
      it { expect(result).to have_received(:buyer_account) }
      it { expect(assigns(:result)).to eq(result) }
    end

    context 'failure' do
      before do
        allow(CreateBuyerAccount).to receive(:perform).and_return(result)
        allow(result).to receive(:success?).and_return(false)
        allow(result).to receive(:errors)
        post :create, new_buyer: { token: 'invalidtoken', card_last_four: '4242', card_type: 'Visa' }
      end
      it { should respond_with(:unprocessable_entity) }
      it { expect(CreateBuyerAccount).to have_received(:perform) }
      it { expect(result).to have_received(:success?) }
      it { expect(result).to have_received(:errors) }
      it { expect(assigns(:result)).to eq(result) }
    end
  end
end
