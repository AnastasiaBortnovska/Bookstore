# frozen_string_literal: true

RSpec.describe ForgotPasswordPage do
  let(:forgot_password_page) { described_class.new }
  let(:home_page) { Home.new }
  let(:user) { create(:user) }
  let(:invalid_user) { FFaker::Internet.email }

  before do
    forgot_password_page.load
  end

  it { expect(forgot_password_page).to be_all_there }

  it 'sets success flash message' do
    forgot_password_page.fill_form(user.email)
    expect(home_page).to have_flash_success(text: I18n.t('devise.passwords.send_instructions'))
  end

  it 'shows errors' do
    forgot_password_page.fill_form(invalid_user)
    expect(forgot_password_page).to have_span_error
  end

  describe 'cancel button' do
    let(:log_in_page) { LogIn.new }

    before { log_in_page.load }

    it 'redirects to log in page' do
      log_in_page.forgot_password.click
      expect(forgot_password_page).to be_displayed
      forgot_password_page.link_cancel.click
      expect(log_in_page).to be_displayed
    end
  end
end
