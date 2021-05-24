# frozen_string_literal: true

RSpec.describe Users::OmniauthCallbacksController do
  describe 'when auth via Facebook' do
    let(:get_facebook) { get :facebook }

    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    end

    context 'when user is new' do
      before do
        allow(User).to receive(:from_omniauth).and_return(build(:user))
        get_facebook
      end

      it { expect(response).to redirect_to(new_user_registration_path) }
    end

    context 'when user exist' do
      before do
        allow(User).to receive(:from_omniauth).and_return(create(:user))
        get_facebook
      end

      it { expect(response).to redirect_to(root_path) }
    end
  end
end
