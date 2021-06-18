# frozen_string_literal: true

RSpec.describe 'Settings' do
  let!(:user) { create(:user) }
  let(:address_page) { AddressPage.new }

  before do
    login_as(user)
    address_page.load(user_id: user.id)
  end

  describe 'Address' do
    let(:valid_data) { attributes_for :address }
    let(:invalid_data) { attributes_for :address, first_name: rand(150) }

    it { expect(address_page).to be_all_there }

    context 'when fill billing address' do
      it 'sets success flash message' do
        address_page.billing_address_section.fill_in(valid_data)
        expect(address_page).to have_flash_success(text: I18n.t('message.success.address.update',
                                                                type: I18n.t('devise.registrations.edit.billing')))
      end

      it 'sets failure flash message' do
        address_page.billing_address_section.fill_in(invalid_data)
        expect(address_page).to have_flash_failure(text: /#{I18n.t('message.error.address.text_field')}/)
      end
    end

    context 'when fill shipping address' do
      it 'sets success flash message' do
        address_page.shipping_address_section.fill_in(valid_data)
        expect(address_page).to have_flash_success(text: I18n.t('message.success.address.update',
                                                                type: I18n.t('devise.registrations.edit.shipping')))
      end

      it 'sets failure flash message' do
        address_page.shipping_address_section.fill_in(invalid_data)
        expect(address_page).to have_flash_failure(text: /#{I18n.t('message.error.address.text_field')}/)
      end
    end
  end

  describe 'Privacy' do
    let(:home_page) { Home.new }
    let(:privacy_page) { PrivacyPage.new }

    before do
      address_page.tab_privacy.click
    end

    it { expect(privacy_page).to be_all_there }

    context 'when fill email form' do
      it 'sets success flash message' do
        privacy_page.email_form.fill_in(FFaker::Internet.email)
        expect(home_page).to have_flash_success(text: I18n.t('message.success.user.update_email'))
      end

      it 'doesnt set success flash message' do
        privacy_page.email_form.fill_in(FFaker::Name.first_name)
        expect(home_page).not_to have_flash_success(text: I18n.t('message.success.user.update_email'))
      end
    end

    context 'when fill password form' do
      let(:invalid_password) do
        { current_password: FFaker::String.from_regexp(User::PASSWORD_FORMAT),
          password: FFaker::String.from_regexp(User::PASSWORD_FORMAT) }
      end

      it 'sets success flash message' do
        privacy_page.password_form.fill_in({ current_password: user.password,
                                             password: FFaker::String.from_regexp(User::PASSWORD_FORMAT) })
        expect(home_page).to have_flash_success(text: I18n.t('message.success.user.update_password'))
      end

      it 'doesnt set success flash message' do
        privacy_page.password_form.fill_in(invalid_password)
        expect(home_page).not_to have_flash_success(text: I18n.t('message.success.user.update_password'))
      end
    end

    context 'when remove account' do
      it 'sets success flash message' do
        privacy_page.remove_account_form.remove_account
        expect(home_page).to have_flash_success(text: I18n.t('message.success.user.destroy'))
      end
    end
  end
end
