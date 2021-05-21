# frozen_string_literal: true

RSpec.describe BooksQuery do
  subject(:query) { described_class.new(params).call }

  let(:books) { create_list(:book, 3, category: category) }
  let(:category) { create(:category) }

  context 'when filter are set' do
    let(:filter) { BooksQuery::BOOK_FILTERING_ORDER.keys[3] }
    let(:params) { { category_id: category.id, sort_by: filter } }

    it do
      expect(query).to eq(category.books.order(filter))
    end
  end

  context 'when wrong filter' do
    let(:invalid_filter) { 'invalid' }
    let(:params) { { category_id: category.id, sort_by: invalid_filter } }

    it do
      expect(query).to eq(category.books.order(BooksQuery::BOOK_FILTERING_ORDER.keys[0]))
    end
  end
end
