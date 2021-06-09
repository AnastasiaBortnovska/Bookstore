# frozen_string_literal: true

RSpec.describe SingUp do
  let(:sing_up_page) { described_class.new }
  let(:home_page) { Home.new }
  let(:valid_data) { attributes_for :user }
  let(:invalid_data) { attributes_for :user, email: FFaker::Book.title }

  before do
    sing_up_page.load
  end

  it { expect(sing_up_page).to be_all_there }

  it 'sets success flash message' do
    sing_up_page.sign_in(valid_data)
    expect(home_page).to have_flash_success(text: I18n.t('devise.registrations.signed_up'))
  end

  it 'sets failure flash message' do
    sing_up_page.sign_in(invalid_data)
    expect(home_page).not_to have_flash_success(text: I18n.t('devise.registrations.signed_up'))
  end
end
