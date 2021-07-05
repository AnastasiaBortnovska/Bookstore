# frozen_string_literal: true

RSpec.describe Delivery do
  context 'with associations' do
    it { is_expected.to have_many(:orders).dependent(:destroy) }
  end
end
