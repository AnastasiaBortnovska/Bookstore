# frozen_string_literal: true

RSpec.describe Users::OmniauthCallbacksController do
  let(:get_facebook) { get :facebook }

  shared_examples 'successfully logged in' do
    it { expect(response).to redirect_to(root_path) }
    it { is_expected.to set_flash[:notice].to(/#{I18n.t('devise.omniauth_callbacks.facebook')}/) }
  end

  describe '#facebook' do
    describe 'success' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        request.env['omniauth.auth'] = stub_facebook_omniauth(params)
        get_facebook
      end

      context 'when user is created' do
        let(:params) { { uid: rand(5), email: FFaker::Internet.email } }

        it { expect(User.last.email).to eq(params[:email]) }

        include_examples 'successfully logged in'
      end

      context 'when user is found' do
        let!(:user) { create(:user, :with_provider, :with_uid) }
        let(:params) { { uid: user.uid } }

        it { expect(User.count).to eq(1) }

        include_examples 'successfully logged in'
      end
    end

    describe 'failure' do
      let(:user) { create(:user, :with_provider) }

      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        allow(User).to receive(:from_omniauth).and_return(user)
        allow(user).to receive(:persisted?).and_return(false)
        get_facebook
      end

      it { expect(response).to redirect_to(new_user_registration_url) }
      it { is_expected.to set_flash[:alert].to(/#{I18n.t('devise.omniauth_callbacks.facebook')}/) }
    end
  end
end
