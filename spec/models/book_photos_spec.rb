# frozen_string_literal: true

RSpec.describe BookPhoto do
  it { is_expected.to belong_to(:book) }
end
