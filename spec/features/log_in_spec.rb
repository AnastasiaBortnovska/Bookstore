# frozen_string_literal: true

RSpec.describe LogIn do
  describe 'Log in' do
    let(:log_in_page) { described_class.new }
    let(:home_page) { Home.new }
    let(:user) { create(:user) }
    let(:invalid_email) { FFaker::Book.title }

    before do
      log_in_page.load
    end

    it { expect(log_in_page).to be_all_there }

    it 'with valid data' do
      log_in_page.sign_in!(user.email, user.password)
      expect(home_page).to have_div_success(text: I18n.t('devise.sessions.signed_in'))
    end

    it 'with invalid data' do
      log_in_page.sign_in!(invalid_email, user.password)
      expect(home_page).to have_div_danger(text: I18n.t('devise.failure.not_found_in_database',
                                                        authentication_keys: 'Email'))
    end
  end
end
