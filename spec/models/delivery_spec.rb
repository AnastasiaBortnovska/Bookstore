# frozen_string_literal: true

RSpec.describe Delivery do
  context 'with associations' do
    it { is_expected.to have_many(:order_deliveries).dependent(:destroy) }
  end
end
