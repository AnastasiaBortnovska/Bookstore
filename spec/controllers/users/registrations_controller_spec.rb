# frozen_string_literal: true

RSpec.describe Users::RegistrationsController do
  let(:user) { create(:user) }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  shared_examples 'successfully updated' do
    it { expect(response).to redirect_to(edit_user_registration_path) }
  end

  shared_examples 'failurefull updated' do
    it { expect(response).to render_template(:edit) }
  end

  describe 'update user address' do
    context 'when success' do
      before { put :update, params: params }

      let(:params) do
        { user: { billing_address_attributes: attributes_for(:address) } }
      end

      it { expect(user.billing_address).not_to be_nil }
    end

    context 'when failure' do
      before { put :edit, params: params }

      let(:params) { attributes_for(:address, first_name: nil) }

      it { expect(user.billing_address).to be_nil }

      include_examples 'failurefull updated'
    end
  end

  describe 'update user email' do
    before { put :update, params: params }

    context 'when success' do
      let(:params) do
        { user: { email: FFaker::Internet.email } }
      end

      include_examples 'successfully updated'
    end

    context 'when failure' do
      let(:params) do
        { user: { email: FFaker::Name.first_name } }
      end

      include_examples 'failurefull updated'
    end
  end

  describe 'update user password' do
    let(:password) { FFaker::String.from_regexp(User::PASSWORD_FORMAT) }

    before { put :update, params: params }

    context 'when success' do
      let(:params) do
        { user: { password: password, password_confirmation: password, current_password: user.password } }
      end

      include_examples 'successfully updated'
    end

    context 'when failure' do
      let(:params) do
        { user: { password: password, password_confirmation: password, current_password: nil } }
      end

      include_examples 'failurefull updated'
    end
  end
end
