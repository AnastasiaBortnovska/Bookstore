# frozen_string_literal: true

RSpec.describe CreditCard do
  describe 'assosiations' do
    it { is_expected.to belong_to(:order) }
  end
end
