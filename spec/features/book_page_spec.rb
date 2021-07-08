# frozen_string_literal: true

RSpec.describe BookPage do
  let!(:book) { create(:book).decorate }

  let(:book_page) { described_class.new }

  describe 'content' do
    before { book_page.load(book_id: book.id) }

    it 'all elements are present' do
      expect(book_page).to have_book_name(text: book.title)
      expect(book_page).to have_book_price(text: "€#{book.price}")
      expect(book_page).to have_book_authors(text: book.authors_as_string)
      expect(book_page).to have_book_dimensions(text: book.dimensions)
    end

    it 'button #read more works' do
      book_page.btn_read_more.click
      expect(book_page).to have_book_all_description
    end
  end
end
