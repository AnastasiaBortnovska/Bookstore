# frozen_string_literal: true

RSpec.describe ForgotPasswordPage do
  let(:forgot_password_page) { described_class.new }

  describe 'Forgot password' do
    let(:user) { create(:user) }
    let(:invalid_user) { FFaker::Internet.email }

    before do
      forgot_password_page.load
    end

    it { expect(forgot_password_page).to be_all_there }

    it 'with valid email' do
      forgot_password_page.fill_form(user.email)
      expect(page).to have_current_path('/users/sign_in')
      expect(page).to have_selector 'div.alert.alert-success', text: I18n.t('devise.passwords.send_instructions')
    end

    it 'with invalid email' do
      forgot_password_page.fill_form(invalid_user)
      expect(page).to have_no_current_path('/users/sign_in')
      expect(forgot_password_page).to have_selector 'span.error', text: I18n.t('errors.messages.not_found')
    end
  end

  describe 'cancel button' do
    let(:log_in_page) { LogIn.new }

    before { log_in_page.load }

    it 'click cancel button' do
      log_in_page.forgot_password.click
      expect(forgot_password_page).to be_displayed
      forgot_password_page.link_cancel.click
      expect(page).to have_current_path('/users/sign_in')
    end
  end
end
