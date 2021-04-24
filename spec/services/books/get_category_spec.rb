# frozen_string_literal: true

RSpec.describe Books::GetCategory do
  let(:get_category_service) { described_class.new(params) }

  let(:books) { create_list(:book, 3) }
  let(:category) { create(:category) }

  context 'when filter are set' do
    let(:filter) { Filtering::BOOK_FILTERING_ORDER.keys[3] }
    let(:params) { { category_id: category.id, sort_by: filter } }

    it do
      allow(Category).to receive(:find).and_return(category)
      expect(get_category_service.call).to eq category.books.order(filter)
    end
  end

  context 'when wrong filter' do
    let(:invalid_filter) { 'invalid' }
    let(:params) { { category_id: category.id, sort_by: invalid_filter } }

    it do
      allow(Category).to receive(:find).and_return(category)
      expect(get_category_service.call).to eq category.books.order(Filtering::BOOK_FILTERING_ORDER.keys[0])
    end
  end
end
