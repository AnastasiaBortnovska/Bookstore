# frozen_string_literal: true

RSpec.describe OrdersQuery do
  subject(:query) { described_class.new(user, params).call }

  let(:order) { create_list(:order, 3, status: :in_delivery, user: user) }
  let(:user) { create(:user) }

  context 'when filter sets up' do
    let(:filter) { :in_delivery }
    let(:params) { { filter: filter } }

    it { expect(query).to eq(user.orders.where(status: filter)) }
  end

  context 'when filter doesnt set up' do
    let(:params) { { filter: nil } }

    it { expect(query).to eq(user.orders.order(OrdersQuery::DEFAULT_SORT)) }
  end

  context 'when wrong filter' do
    let(:params) { { filter: FFaker::Name.first_name } }

    it { expect(query).to eq(user.orders.order(OrdersQuery::DEFAULT_SORT)) }
  end
end
