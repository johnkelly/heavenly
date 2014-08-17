require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:question) { FactoryGirl.build_stubbed_uuid(:question) }

  before do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_person).and_return(person)
  end

  describe 'POST #create' do
    context 'success' do
      before do
        allow(person).to receive(:questions).and_return(question)
        allow(question).to receive(:new).and_return(question)
        allow(question).to receive(:save).and_return(true)
        post :create, question: { product_id: 'fakeid', question: 'Is it on?' }
      end
      it { should respond_with(:ok) }
      it { expect(person).to have_received(:questions) }
      it { expect(question).to have_received(:new) }
      it { expect(question).to have_received(:save) }
    end

    context 'failure' do
      before do
        allow(person).to receive(:questions).and_return(question)
        allow(question).to receive(:new).and_return(question)
        allow(question).to receive(:save).and_return(false)
        post :create, question: { product_id: '', question: 'Is it on?' }
      end
      it { should respond_with(:unprocessable_entity) }
      it { expect(person).to have_received(:questions) }
      it { expect(question).to have_received(:new) }
      it { expect(question).to have_received(:save) }
    end
  end
end
