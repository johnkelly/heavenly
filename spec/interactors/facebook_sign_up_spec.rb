require 'rails_helper'

RSpec.describe FacebookSignUp do
  let(:facebook) { FactoryGirl.build_stubbed_uuid(:facebook) }
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:interactor_no_token) { FacebookSignUp.new({}) }
  let(:interactor_token) { FacebookSignUp.new(token: 'fake_token') }
  let(:errors) { %w(Error1 Error2) }

  context 'successful sign up with token' do
    before do
      allow(interactor_token).to receive(:assert_correct_facebook_info)
      allow(interactor_token).to receive(:build_person_from_facebook).and_return(person)
      allow(person).to receive(:save).and_return(true)
      allow(person).to receive(:facebook).and_return(facebook)
      allow(facebook).to receive(:exchange_access_token)
      interactor_token.perform
    end
    it { expect(interactor_token).to have_received(:assert_correct_facebook_info) }
    it { expect(interactor_token).to have_received(:build_person_from_facebook) }
    it { expect(person).to have_received(:save) }
    it { expect(person).to have_received(:facebook) }
    it { expect(facebook).to have_received(:exchange_access_token) }
  end

  context 'failed sign up with token' do
    before do
      allow(interactor_token).to receive(:assert_correct_facebook_info)
      allow(interactor_token).to receive(:build_person_from_facebook).and_return(person)
      allow(person).to receive(:save).and_return(false)
      allow(person).to receive(:errors).and_return(errors)
      allow(errors).to receive(:full_messages).and_return('')
      interactor_token.perform
    end
    it { expect(interactor_token).to have_received(:assert_correct_facebook_info) }
    it { expect(interactor_token).to have_received(:build_person_from_facebook) }
    it { expect(person).to have_received(:save) }
    it { expect(person).to have_received(:errors) }
    it { expect(errors).to have_received(:full_messages) }
  end

  context 'misssing token' do
    it 'returns an error message' do
      interactor_no_token.perform
      expect(interactor_no_token.errors).to eq(['Missing Facebook access token'])
    end
  end
end
