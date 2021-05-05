# frozen_string_literal: true

RSpec.describe BookDecorator do
  let(:book) { create(:book, :attach_author).decorate }

  describe '#authors_as_string' do
    let(:book_author) { book.authors.map(&:full_name).join(', ') }

    it { expect(book.authors_as_string).to eq book_author }
  end

  describe '#material_as_string' do
    let(:book_material) { book.material.capitalize }

    it { expect(book.material_as_string).to eq book_material }
  end

  describe '#dimensions' do
    it {
      expect(book.dimensions).to eq I18n.t('decorator.dimensions', height: book.height, width: book.width,
                                                                   depth: book.depth)
    }
  end

  describe 'description' do
    let(:length) { BookDecorator::DESCRIPTION_LENGTH }
    let(:description) { book.description }

    it '#short_description' do
      expect(book.short_description).to eq description.split('.').first
    end

    it '#medium_description' do
      expect(book.medium_description.length).to eq description[..length].size
    end

    it '#all_description' do
      expect(book.all_description.size).to eq description[(length + 1)..].length
    end

    it '#description_less_240' do
      allow(book.description).to receive(:size) { length - 5 }
      expect(book.description_less_240?).to eq true
    end
  end
end
