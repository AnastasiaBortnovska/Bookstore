# frozen_string_literal: true

RSpec.describe 'Home' do
  let(:home_page) { Home.new }

  describe 'content' do
    before do
      home_page.load
    end

    it { expect(home_page).to be_all_there }
    it { expect(home_page.item_best_sellers.size).to eq(4) }
  end

  describe 'menu' do
    let!(:categories) { create_list(:category, 3) }

    before do
      home_page.load
    end

    it do
      home_page.btn_shop.click
      expect(home_page).to have_menu
      categories.each do |category|
        expect(home_page.menu).to have_item_menu(text: category.name)
      end
    end
  end
end
