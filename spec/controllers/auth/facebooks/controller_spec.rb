require 'rails_helper'

RSpec.describe Auth::FacebooksController, type: :controller do
  let(:result) { Interactor::Context.build }

  describe 'POST #create' do
    context 'sign up' do
      before do
        allow(controller).to receive(:new_person?).and_return(true)
      end

      context 'success' do
        before do
          allow(FacebookSignUp).to receive(:perform).and_return(result)
          allow(result).to receive(:success?).and_return(true)
          allow(result).to receive(:person)
          post :create, facebook: { token: 'faketoken' }
        end
        it { should respond_with(:ok) }
        it { expect(FacebookSignUp).to have_received(:perform) }
        it { expect(result).to have_received(:success?) }
        it { expect(result).to have_received(:person) }
        it { expect(assigns(:result)).to eq(result) }
      end

      context 'failure' do
        before do
          allow(FacebookSignUp).to receive(:perform).and_return(result)
          allow(result).to receive(:success?).and_return(false)
          allow(result).to receive(:errors)
          post :create, facebook: { token: 'faketoken' }
        end
        it { should respond_with(:unprocessable_entity) }
        it { expect(FacebookSignUp).to have_received(:perform) }
        it { expect(result).to have_received(:success?) }
        it { expect(result).to have_received(:errors) }
        it { expect(assigns(:result)).to eq(result) }
      end
    end

    context 'sign in' do
      before do
        allow(controller).to receive(:new_person?).and_return(false)
      end

      context 'success' do
        before do
          allow(FacebookSignIn).to receive(:perform).and_return(result)
          allow(result).to receive(:success?).and_return(true)
          allow(result).to receive(:person)
          post :create, facebook: { token: 'faketoken' }
        end
        it { should respond_with(:ok) }
        it { expect(FacebookSignIn).to have_received(:perform) }
        it { expect(result).to have_received(:success?) }
        it { expect(result).to have_received(:person) }
        it { expect(assigns(:result)).to eq(result) }
      end

      context 'failure' do
        before do
          allow(FacebookSignIn).to receive(:perform).and_return(result)
          allow(result).to receive(:success?).and_return(false)
          allow(result).to receive(:errors)
          post :create, facebook: { token: 'faketoken' }
        end
        it { should respond_with(:unprocessable_entity) }
        it { expect(FacebookSignIn).to have_received(:perform) }
        it { expect(result).to have_received(:success?) }
        it { expect(result).to have_received(:errors) }
        it { expect(assigns(:result)).to eq(result) }
      end
    end
  end
end
