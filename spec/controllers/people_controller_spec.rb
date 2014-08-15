require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:facebook) { FactoryGirl.build_stubbed_uuid(:facebook) }

  before do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_person).and_return(person)
  end

  describe 'GET #show' do
    before do
      allow(person).to receive(:facebook).and_return(facebook)
      get :show
    end
    it { should respond_with(:ok) }
    it { expect(person).to have_received(:facebook) }
  end
end
