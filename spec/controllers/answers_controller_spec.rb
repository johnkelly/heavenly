require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:person) { FactoryGirl.build_stubbed_uuid(:person) }
  let(:question) { FactoryGirl.build_stubbed_uuid(:question) }

  before do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_person).and_return(person)
  end

  describe 'POST #create' do
    context 'success' do
      before do
        allow(Question).to receive(:find).and_return(question)
        allow(question).to receive(:update).and_return(true)
        post :create, question_id: question.to_param, answer: { answer: 'Yes!' }
      end
      it { should respond_with(:ok) }
      it { expect(question).to have_received(:update) }
    end

    context 'failure' do
      before do
        allow(Question).to receive(:find).and_return(question)
        allow(question).to receive(:update).and_return(false)
        post :create, question_id: question.to_param, answer: { answer: '' }
      end
      it { should respond_with(:unprocessable_entity) }
      it { expect(Question).to have_received(:find) }
      it { expect(question).to have_received(:update) }
    end
  end
end
