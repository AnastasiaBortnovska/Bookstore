# frozen_string_literal: true

RSpec.describe CreditCard do
  describe 'assosiations' do
    it { is_expected.to have_one(:order).dependent(:destroy) }
  end
end
