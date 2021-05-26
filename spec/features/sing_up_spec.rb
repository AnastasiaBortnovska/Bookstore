# frozen_string_literal: true

RSpec.describe SingUp do
  describe 'Sign up' do
    let(:sing_up_page) { described_class.new }
    let(:valid_data) { attributes_for :user }
    let(:invalid_data) { attributes_for :user, email: '@@' }

    before do
      sing_up_page.load
    end

    it { expect(sing_up_page).to be_all_there }

    it 'sign up with valid data' do
      sing_up_page.sign_in!(valid_data)
      expect(page).to have_current_path(root_path, ignore_query: true)
      expect(page).to have_selector 'div.alert.alert-success',
                                    text: I18n.t('devise.registrations.signed_up_but_unconfirmed')
    end

    it 'sign up with invalid data' do
      sing_up_page.sign_in!(invalid_data)
      expect(page).to have_no_current_path(root_path, ignore_query: true)
      expect(page).not_to have_selector 'div.alert.alert-success',
                                        text: I18n.t('devise.registrations.signed_up_but_unconfirmed')
    end

    it 'click facebook icon' do
      sing_up_page.facebook_link.click
      expect(page).to have_selector 'div.alert.alert-success',
                                    text: I18n.t('devise.omniauth_callbacks.success',
                                                 kind: I18n.t('devise.omniauth_callbacks.facebook'))
    end
  end
end
