# frozen_string_literal: true

RSpec.describe 'BookPage' do
  let(:book_page) { BookPage.new }
  let!(:book) { create(:book).decorate }

  describe 'content' do
    before do
      book_page.load(book_id: book.id)
    end

    it {
      expect(book_page).to have_book_name(text: book.name)
      expect(book_page).to have_book_price(text: I18n.t('books.partials.book.price', price: book.price))
      expect(book_page).to have_book_authors(text: book.authors_as_string)
      expect(book_page).to have_book_dimensions(text: book.dimensions)
    }

    it {
      book_page.btn_read_more.click
      expect(book_page).to have_book_all_description
    }
  end
end
