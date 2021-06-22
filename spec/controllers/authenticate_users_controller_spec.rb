# frozen_string_literal: true

RSpec.describe AuthenticateUsersController do
  let(:order) { create(:order) }

  shared_examples 'successfully logged in' do
    it { expect(response).to have_http_status(:found) }
    it { expect(order.user).to eq(User.last) }
    it { expect(response).to redirect_to(checkout_path(:addresses)) }
  end

  before { allow(controller).to receive(:current_order).and_return(order) }

  describe '#create' do
    before { post :create, params: params }

    context 'when valid params' do
      let(:email) { FFaker::Internet.email }
      let(:params) do
        { user: { email: email } }
      end

      it { expect(User.last.email).to eq(email) }

      include_examples 'successfully logged in'
    end

    context 'when invalid params' do
      let(:params) do
        { user: { email: FFaker::Name.first_name } }
      end

      it { expect(User.last).to eq(nil) }
      it { expect(subject).to set_flash[:danger].to(I18n.t('message.error.user.authenticate_new_user')) }
    end
  end

  describe '#show' do
    let!(:user) { create(:user) }

    before { get :show, params: params }

    context 'when valid params' do
      let(:params) do
        { id: 2, user: { email: user.email, password: user.password } }
      end

      include_examples 'successfully logged in'
    end

    context 'when invalid params' do
      let(:params) do
        { id: 2, user: { email: FFaker::Name.first_name, password: user.password } }
      end

      it { expect(order.user).to eq nil }
      it { expect(subject).to set_flash[:danger].to(I18n.t('message.error.user.authenticate_user')) }
    end
  end
end
