require 'rails_helper'

RSpec.describe SellsController, type: :controller do
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:product) { FactoryGirl.build_stubbed_uuid(:product) }
  let(:result) { Interactor::Context.build }

  before do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_person).and_return(person)
  end

  describe 'POST #create' do
    context 'success' do
      before do
        allow(Product).to receive(:find).and_return(product)
        allow(SellProduct).to receive(:perform).and_return(result)
        allow(result).to receive(:success?).and_return(true)
        allow(result).to receive(:sell_receipt)
        post :create, product_id: product.to_param, sell: { pickup_at: Time.now.to_s }
      end
      it { should respond_with(:created) }
      it { expect(Product).to have_received(:find) }
      it { expect(SellProduct).to have_received(:perform) }
      it { expect(result).to have_received(:success?) }
      it { expect(result).to have_received(:sell_receipt) }
      it { expect(assigns(:result)).to eq(result) }
    end

    context 'failure' do
      before do
        allow(Product).to receive(:find).and_return(product)
        allow(SellProduct).to receive(:perform).and_return(result)
        allow(result).to receive(:success?).and_return(false)
        allow(result).to receive(:errors)
        post :create, product_id: product.to_param, sell: { pickup_at: 'hamburger' }
      end
      it { should respond_with(:unprocessable_entity) }
      it { expect(Product).to have_received(:find) }
      it { expect(SellProduct).to have_received(:perform) }
      it { expect(result).to have_received(:success?) }
      it { expect(result).to have_received(:errors) }
      it { expect(assigns(:result)).to eq(result) }
    end
  end
end
