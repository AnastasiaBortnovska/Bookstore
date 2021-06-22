# frozen_string_literal: true

RSpec.describe OrderBooksQuery do
  subject(:order_books_query) { described_class.new(order, params) }

  let(:order) { create(:order) }
  let(:order_book) { create(:order_book) }
  let(:random_number) { rand(10) }
  let(:params) { { book_id: order_book.book.id, quantity: random_number } }

  context 'when update book quantity' do
    before { allow(order).to receive_message_chain(:order_books, :find_by).and_return(order_book) }

    it { expect(order_books_query.call).to eq true }

    it 'receives update quantity' do
      expect(order_book).to receive(:update).with(quantity: (order_book.quantity + params[:quantity].to_i))
      order_books_query.call
    end

    it 'changes book quantity by given number' do
      expect { order_books_query.call }.to change(order_book, :quantity).by(random_number)
    end
  end

  context 'when create order book' do
    before { allow(order).to receive_message_chain(:order_books, :find_by).and_return(nil) }

    it do
      expect do
        expect(order).to receive_message_chain(:order_books, :create).with(params)
        order_books_query.call
      end.to change(OrderBook, :count).by(1)
    end
  end
end
