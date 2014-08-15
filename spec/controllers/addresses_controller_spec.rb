require 'rails_helper'

RSpec.describe Person::AddressesController, type: :controller do
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:address) { FactoryGirl.build_stubbed_uuid(:address) }
  let(:errors) { ['Something went wrong'] }

  before do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_person).and_return(person)
  end

  describe 'POST #create' do
    context 'success' do
      before do
        allow(person).to receive(:build_address).and_return(address)
        allow(address).to receive(:save).and_return(true)
        post :create, address: { street1: '1957 California ST', city: 'Mountain View', region: 'CA',
                                 postal_code: '94040', country: 'US', latitude: '23',
                                 longitude: '-23' }
      end
      it { should respond_with(:created) }
      it { expect(person).to have_received(:build_address) }
      it { expect(address).to have_received(:save) }
      it { expect(assigns(:address)).to eq(address) }
    end

    context 'failure' do
      before do
        allow(person).to receive(:build_address).and_return(address)
        allow(address).to receive(:save).and_return(false)
        allow(address).to receive(:errors).and_return(errors)
        allow(errors).to receive(:full_messages)
        post :create, address: { street1: nil, city: 'Mountain View', region: 'CA',
                                 postal_code: '94040', country: 'US', latitude: '23',
                                 longitude: '-23' }
      end
      it { should respond_with(:unprocessable_entity) }
      it { expect(person).to have_received(:build_address) }
      it { expect(address).to have_received(:save) }
      it { expect(address).to have_received(:errors) }
      it { expect(errors).to have_received(:full_messages) }
      it { expect(assigns(:address)).to eq(address) }
    end
  end
end
