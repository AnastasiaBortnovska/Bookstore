# frozen_string_literal: true

RSpec.describe BooksPresenter do
  let(:presenter) { described_class.new }

  describe '#show_name_filter' do
    context 'when valid_filter_attribute' do
      let(:valid_filter_attribute) { BooksQuery::BOOK_FILTERING_ORDER.first[0] }
      let(:valid_filter_name) { BooksQuery::BOOK_FILTERING_ORDER.first[1] }

      it { expect(presenter.show_name_filter(valid_filter_attribute)).to eq(valid_filter_name) }
    end

    context 'when invalid_filter_attribute' do
      let(:invalid_filter_attribute) { FFaker::Name }

      it {
        expect(presenter.show_name_filter(invalid_filter_attribute)).to eq(BooksPresenter::DEFAULT)
      }
    end

    context 'when filter_attribute is nil' do
      let(:invalid_filter_attribute) { nil }

      it {
        expect(presenter.show_name_filter(invalid_filter_attribute)).to eq(BooksPresenter::DEFAULT)
      }
    end
  end
end
