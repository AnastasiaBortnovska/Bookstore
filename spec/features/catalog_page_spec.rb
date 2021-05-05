# frozen_string_literal: true

RSpec.describe 'Catalog' do
  let(:catalog_page) { Catalog.new }

  describe 'content' do
    let!(:books) { BookDecorator.decorate_collection(create_list(:book, Pagy::VARS[:items])) }

    before do
      catalog_page.load
    end

    it {
      books.each do |book|
        expect(catalog_page).to have_book_name(text: book.name)
        expect(catalog_page).to have_authors(text: book.authors_as_string)
      end
    }
  end

  describe 'count books on page' do
    context 'when books count is 12' do
      before do
        create_list(:book, Pagy::VARS[:items])
        catalog_page.load
      end

      it { expect(catalog_page.book_wrapper.size).to eq Pagy::VARS[:items] }
      it { expect(catalog_page).to have_no_button_view_more }
    end

    context 'when books count is 14' do
      before do
        create_list(:book, Pagy::VARS[:items] + 2)
        catalog_page.load
      end

      it { expect(catalog_page.book_wrapper.size).to eq Pagy::VARS[:items] }
      it { expect(catalog_page).to have_button_view_more }
    end
  end

  describe 'category' do
    let!(:books) { create_list(:book, 3) }

    before do
      catalog_page.load
    end

    it { expect(catalog_page.category.count).to eq Category.all.count + 1 }

    it {
      expect(catalog_page.count_book_category.map do |category|
               category.text.to_i
             end).to eq(books.each_with_object([Book.all.count]) do |book, array|
                          array << book.category.books_count
                        end)
    }
  end

  describe 'filter' do
    before do
      catalog_page.load
    end

    it {
      catalog_page.show_filter.click
      expect(catalog_page.filter.count).to eq Books::GetCategory::BOOK_FILTERING_ORDER.count
    }
  end
end
