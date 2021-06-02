# frozen_string_literal: true

RSpec.describe Users::OmniauthCallbacksController do
  shared_examples 'successfully logged in' do
    it 'redirects to root path' do
      expect(response).to redirect_to(root_path)
    end

    it 'sets flash message' do
      expect(flash[:notice]).to eq(I18n.t('devise.omniauth_callbacks.success',
                                          kind: I18n.t('devise.omniauth_callbacks.facebook')))
    end
  end

  let(:get_facebook) { get :facebook }

  context 'when user is not created' do
    let(:user) { create(:user, :with_provider) }

    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      allow(User).to receive(:from_omniauth).and_return(user)
      allow(user).to receive(:persisted?).and_return(false)
      get_facebook
    end

    it 'redirects to path' do
      expect(response).to redirect_to(new_user_registration_url)
    end
  end

  describe '#success' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = stub_facebook_omniauth(params)
      get_facebook
    end

    context 'when user is created' do
      let(:email) { FFaker::Internet.email }
      let(:params) { { uid: rand(5), email: email } }

      it { expect(User.last.email).to eq(email) }

      include_examples 'successfully logged in'
    end

    context 'when user is found' do
      let!(:user) { create(:user, :with_provider, :with_uid) }
      let(:params) { { uid: user.uid } }

      it { expect(User.count).to eq(1) }
      it { expect(User.last.email).to eq(user.email) }

      include_examples 'successfully logged in'
    end
  end
end
