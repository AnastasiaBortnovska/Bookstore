require 'rails_helper'
require_relative 'pages/home'

RSpec.describe 'home page', type: :system do
  let!(:home_page) { Home.new }

  context 'when all elements present' do
    before do
      driven_by(:rack_test)
      home_page.load
    end

    it { expect(home_page).to have_nav_bar }
    it { expect(home_page).to have_slider }
    it { expect(home_page.item_slider.size).to eq(3) }
    it { expect(home_page).to have_btn_prev }
    it { expect(home_page).to have_btn_next }
    it { expect(home_page).to have_best_sellers }
    it { expect(home_page.item_best_sellers.size).to eq(4) }
    it { expect(home_page).to have_footer }
  end

  context 'when have correct content' do
    before { visit '/' }

    it { expect(page).to have_content(I18n.t('header.title')) }
    it { expect(page).to have_content(I18n.t('header.home')) }
    it { expect(page).to have_content(I18n.t('header.shop')) }
    it { expect(page).to have_content(I18n.t('footer.orders')) }
    it { expect(page).to have_content(I18n.t('footer.email')) }
    it { expect(page).to have_content(I18n.t('home_page.greeting')) }
    it { expect(page).to have_content(I18n.t('home_page.btn_start')) }
    it { expect(page).to have_content(I18n.t('home_page.best')) }

    it do
      within('header') { click_link(I18n.t('header.shop')) }
      expect(page).to have_content(I18n.t('header.mobile_dev'))
      expect(page).to have_content(I18n.t('header.photo'))
      expect(page).to have_content(I18n.t('header.desing'))
      expect(page).to have_content(I18n.t('header.my_account'))
    end
  end
end
