# frozen_string_literal: true

RSpec.describe FilterPresenter do
  let(:filter_presenter) { described_class.new }

  describe '#show_name_filter' do
    context 'when valid_filter_attribute' do
      let(:valid_filter_attribute) { Books::GetCategory::BOOK_FILTERING_ORDER.first[0] }
      let(:valid_filter_name) { Books::GetCategory::BOOK_FILTERING_ORDER.first[1] }

      it { expect(filter_presenter.show_name_filter(valid_filter_attribute)).to eq valid_filter_name }
    end

    context 'when invalid_filter_attribute' do
      let(:invalid_filter_attribute) { FFaker::Name }

      it {
        expect(filter_presenter.show_name_filter(invalid_filter_attribute)).to eq Books::GetCategory::DEFAULT_SORT[1]
      }
    end

    context 'when filter_attribute is nil' do
      let(:invalid_filter_attribute) { nil }

      it {
        expect(filter_presenter.show_name_filter(invalid_filter_attribute)).to eq Books::GetCategory::DEFAULT_SORT[1]
      }
    end
  end
end
