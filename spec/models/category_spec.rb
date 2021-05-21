# frozen_string_literal: true

RSpec.describe Category do
  describe 'associations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'callback clear_cache' do
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
    let(:cache) { Rails.cache }
    let(:value) { FFaker::Name.first_name }

    before do
      allow(Rails).to receive(:cache).and_return(memory_store)
      Rails.cache.clear
    end

    it do
      Rails.cache.write('all_categories', value)
      expect(Rails.cache.read('all_categories')).to eq(value)
      create(:category)
      expect(Rails.cache).not_to exist('all_categories')
    end
  end
end
