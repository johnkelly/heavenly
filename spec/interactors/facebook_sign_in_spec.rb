require 'rails_helper'

RSpec.describe FacebookSignIn do
  let(:facebook) { FactoryGirl.build_stubbed_uuid(:facebook) }
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:interactor_no_token) { FacebookSignIn.new({}) }
  let(:interactor_token) { FacebookSignIn.new(token: 'fake_token') }

  context 'has facebook access token' do
    before do
      allow(interactor_token).to receive(:facebook_info).and_return('id' => 'fake_id')
      allow(Facebook).to receive(:where).and_return([facebook])
      allow(facebook).to receive(:exchange_access_token)
      allow(facebook).to receive(:person).and_return(person)
      allow(person).to receive(:update!)
      interactor_token.perform
    end
    it { expect(interactor_token).to have_received(:facebook_info) }
    it { expect(Facebook).to have_received(:where) }
    it { expect(facebook).to have_received(:exchange_access_token) }
    it { expect(facebook).to have_received(:person).twice }
    it { expect(person).to have_received(:update!) }
  end

  context 'missing facebook access token' do
    it 'returns an error message' do
      interactor_no_token.perform
      expect(interactor_no_token.errors).to eq(['Missing Facebook access token'])
    end
  end
end
