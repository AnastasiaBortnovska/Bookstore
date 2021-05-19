# frozen_string_literal: true

RSpec.describe 'Catalog', js: true do
  let(:catalog_page) { Catalog.new }

  describe 'content' do
    let!(:books) { BookDecorator.decorate_collection(create_list(:book, 2)) }

    before do
      catalog_page.load
    end

    it 'all elements are present' do
      books.each do |book|
        expect(catalog_page).to have_book_name(text: book.title)
        expect(catalog_page).to have_authors(text: book.authors_as_string)
      end
    end
  end

  describe 'count books on page' do
    before { Pagy::VARS[:items] = 3 }

    after { Pagy::VARS[:items] = 12 }

    context 'when books count is equal Pagy::VARS[:items]' do
      before do
        create_list(:book, Pagy::VARS[:items])
        catalog_page.load
      end

      it { expect(catalog_page.book_wrapper.size).to eq(Pagy::VARS[:items]) }
      it { expect(catalog_page).to have_no_button_view_more }
    end

    context 'when books count is more then Pagy::VARS[:items]' do
      before do
        create_list(:book, Pagy::VARS[:items] + 2)
        catalog_page.load
      end

      it 'when click on button view more and show last page with books' do
        expect(catalog_page.book_wrapper.size).to eq(Pagy::VARS[:items])
        catalog_page.button_view_more.click
        expect(catalog_page.book_wrapper.size).to eq(Pagy::VARS[:items] + 2)
        expect(catalog_page).not_to have_button_view_more
      end
    end
  end

  describe 'filter' do
    before do
      catalog_page.load
    end

    it 'button #show_filter works' do
      catalog_page.show_filter.click
      expect(catalog_page.filter.count).to eq BooksQuery::BOOK_FILTERING_ORDER.count
    end
  end
end
