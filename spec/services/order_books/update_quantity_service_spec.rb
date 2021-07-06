# frozen_string_literal: true

RSpec.describe OrderBooks::UpdateQuantityService do
  let(:update_quantity_service) { described_class.new(params) }
  let(:quantity_actions) { OrderBooks::UpdateQuantityService::QUANTITY_ACTION }

  before { allow(OrderBook).to receive(:find).and_return(order_book) }

  context 'when increment order book quantity' do
    let(:order_book) { create(:order_book) }
    let(:params) do
      { id: order_book.id, quantity_action: quantity_actions[:increment] }
    end

    it { expect { update_quantity_service.call }.to change(order_book, :quantity).by(1) }
  end

  context 'when decrement order book quantity' do
    let(:order_book) { create(:order_book, quantity: 2) }
    let(:params) do
      { id: order_book.id, quantity_action: quantity_actions[:decrement] }
    end

    it { expect { update_quantity_service.call }.to change(order_book, :quantity).by(-1) }
  end

  context 'when decrement when quantity equals 1' do
    let(:order_book) { create(:order_book, quantity: 1) }
    let(:params) do
      { id: order_book.id, quantity_action: quantity_actions[:decrement] }
    end

    it { expect { update_quantity_service.call }.not_to change(order_book, :quantity) }
  end
end
