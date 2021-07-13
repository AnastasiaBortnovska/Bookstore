# frozen_string_literal: true

RSpec.describe OrderDelivery do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:delivery) }
  end
end
