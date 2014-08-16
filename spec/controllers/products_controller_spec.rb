require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:address) { FactoryGirl.build_stubbed_uuid(:address) }
  let(:product) { FactoryGirl.build_stubbed_uuid(:product) }
  let(:facebook) { FactoryGirl.build_stubbed_uuid(:facebook) }
  let(:errors) { ['Something went wrong'] }

  before do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_person).and_return(person)
    allow(product).to receive(:buyer).and_return(person)
    allow(product).to receive(:seller).and_return(person)
    allow(person).to receive(:facebook).and_return(facebook)
    allow(person).to receive(:address).and_return(address)
  end

  describe 'GET #index' do
    context 'no params' do
      before do
        allow(Product).to receive(:search_within_ten_miles).and_return([product])
        get :index
      end
      it { should respond_with(:ok) }
      it { expect(Product).to have_received(:search_within_ten_miles) }
    end

    context 'all params' do
      before do
        allow(Product).to receive(:search_within_ten_miles).with('34.56'.to_d, '-122'.to_d, 'Macbook').and_return([product])
        get :index, latitude: '34.56', longitude: '-122', term: 'Macbook'
      end
      it { should respond_with(:ok) }
      it { expect(Product).to have_received(:search_within_ten_miles) }
    end
  end

  describe 'POST #create' do
    context 'success' do
      before do
        allow(person).to receive(:sold_products).and_return(product)
        allow(product).to receive(:new).and_return(product)
        allow(product).to receive(:save).and_return(true)
        allow(product).to receive(:as_json)
        post :create, product: { title: 'WAT', description: 'WAT WAT',
                                 price: '4999', video_url: 'https://google.com',
                                 on_sale: 'true' }
      end
      it { should respond_with(:created) }
      it { expect(person).to have_received(:sold_products) }
      it { expect(product).to have_received(:new) }
      it { expect(product).to have_received(:save) }
    end

    context 'failure' do
      before do
        allow(person).to receive(:sold_products).and_return(product)
        allow(product).to receive(:new).and_return(product)
        allow(product).to receive(:save).and_return(false)
        allow(product).to receive(:errors).and_return(errors)
        allow(errors).to receive(:full_messages).and_return(errors)
        post :create, product: { title: 'WAT', description: 'WAT WAT',
                                 price: '4999', on_sale: 'true' }
      end
      it { should respond_with(:unprocessable_entity) }
      it { expect(person).to have_received(:sold_products) }
      it { expect(product).to have_received(:new) }
      it { expect(product).to have_received(:save) }
      it { expect(product).to have_received(:errors) }
      it { expect(errors).to have_received(:full_messages) }
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      before do
        allow(Product).to receive(:find).and_return(product)
        allow(product).to receive(:update).and_return(true)
        patch :update, id: product.to_param, product: { title: 'New WAT' }
      end
      it { should respond_with(:ok) }
      it { expect(Product).to have_received(:find) }
      it { expect(product).to have_received(:update) }
    end

    context 'failure' do
      before do
        allow(Product).to receive(:find).and_return(product)
        allow(product).to receive(:update).and_return(false)
        allow(product).to receive(:errors).and_return(errors)
        allow(errors).to receive(:full_messages).and_return(errors)
        patch :update, id: product.to_param, product: { title: '' }
      end
      it { should respond_with(:unprocessable_entity) }
      it { expect(Product).to have_received(:find) }
      it { expect(product).to have_received(:update) }
      it { expect(product).to have_received(:errors) }
      it { expect(errors).to have_received(:full_messages) }
    end
  end

  describe 'GET #show' do
    before do
      allow(Product).to receive(:find).and_return(product)
      get :show, id: product.to_param
    end
    it { should respond_with(:ok) }
    it { expect(Product).to have_received(:find) }
  end
end
