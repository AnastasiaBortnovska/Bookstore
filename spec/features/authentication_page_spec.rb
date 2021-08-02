# frozen_string_literal: true

RSpec.describe AuthenticationPage do
  let(:authentication_page) { described_class.new }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(build(:order))
    authentication_page.load
  end

  it { expect(authentication_page).to be_all_there }

  describe 'login form' do
    let!(:user) { create(:user) }

    context 'when valid params' do
      it 'redirect to address step' do
        authentication_page.login_form.fill_in(user.email, user.password)
        expect(page).to have_current_path '/checkout/address'
      end
    end

    context 'when invalid params' do
      let(:email) { FFaker::Internet.email }

      it 'shows flash failure message' do
        authentication_page.login_form.fill_in(email, user.password)
        expect(authentication_page).to have_flash_failure(text: I18n.t('message.error.user.authenticate_user'))
      end
    end
  end

  describe 'registration form' do
    context 'when valid params' do
      it 'redirect to address step' do
        authentication_page.registration_form.fill_in(FFaker::Internet.email)
        expect(page).to have_current_path '/checkout/address'
      end
    end

    context 'when user exists' do
      let!(:user) { create(:user) }

      it 'shows flash failure message' do
        authentication_page.registration_form.fill_in(user.email)
        expect(authentication_page).to have_flash_failure(text: I18n.t('message.error.user.authenticate_new_user'))
      end
    end
  end
end
