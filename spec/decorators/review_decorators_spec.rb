# frozen_string_literal: true

RSpec.describe ReviewDecorator do
  let(:review) { create(:review).decorate }

  it { expect(review.slash_date_format).to eq(review.created_at.strftime('%m/%d/%Y')) }
end
