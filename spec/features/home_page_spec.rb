# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home' do
  let!(:home_page) { Home.new }

  context 'when all elements present' do
    before do
      home_page.load
    end

    it { expect(home_page).to be_all_there }
    it { expect(home_page.item_best_sellers.size).to eq(4) }
  end

  context 'when have correct menu' do
    before do
      home_page.load
    end

    it do
      within(home_page.header) { click_link(I18n.t('header.shop')) }
      expect(home_page).to have_content(I18n.t('header.mobile_dev'))
      expect(home_page).to have_content(I18n.t('header.photo'))
      expect(home_page).to have_content(I18n.t('header.desing'))
      expect(home_page).to have_content(I18n.t('header.my_account'))
    end
  end
end
