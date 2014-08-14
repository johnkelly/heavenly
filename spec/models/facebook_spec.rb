require 'rails_helper'

RSpec.describe Facebook, type: :model do
  let(:facebook) { FactoryGirl.build_stubbed_uuid(:facebook) }
  let(:graph) { { empty: 'hash' } }
  let(:oauth) { { empty: 'hash' } }

  describe 'associations' do
    it { should belong_to(:person) }
  end

  describe 'self.person_json' do
    before do
      allow(Koala::Facebook::API).to receive(:new).and_return(graph)
      allow(graph).to receive(:get_object)
      Facebook.person_json('fake_token')
    end
    it { expect( Koala::Facebook::API).to have_received(:new) }
    it { expect(graph).to have_received(:get_object) }
  end

  describe 'exchange_access_token' do
    before do
      allow(facebook).to receive(:oauth).and_return(oauth)
      allow(oauth).to receive(:exchange_access_token_info).and_return('access_token' => 'faketoken', 'expires' => 50000)
      allow(facebook).to receive(:update!)
      facebook.exchange_access_token('fake_token')
    end
    it { expect(facebook).to have_received(:oauth) }
    it { expect(oauth).to have_received(:exchange_access_token_info) }
    it { expect(facebook).to have_received(:update!) }
  end
end
