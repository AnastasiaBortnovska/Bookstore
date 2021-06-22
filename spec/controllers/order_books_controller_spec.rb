# frozen_string_literal: true

RSpec.describe OrderBooksController do
  let(:user) { create(:user) }
  let(:order) { create(:order) }
  let(:order_book) { create(:order_book) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe '#index' do
    let(:order_book) { create(:order_book, order: order) }

    before do
      allow(controller).to receive(:current_order).and_return(order)
      get :index
    end

    it { expect(assigns(:current_cart)).to eq(OrderBook.where(order: order)) }
  end

  describe '#create' do
    before { post :create, params: params }

    let(:params) { { order_book: attributes_for(:order_book) } }

    it { expect(response).to have_http_status(:found) }
    it { expect(Order.last.user).to eq(user) }
    it { expect(session[:order_id]).to eq(Order.last.id) }
  end

  describe '#update' do
    before { put :update, params: params }

    context 'when success' do
      let(:params) do
        { id: order_book.id, order_book: attributes_for(:order_book) }
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to(order_books_path) }
    end

    context 'when failure' do
      let(:params) do
        { id: order_book.id, order_book: nil }
      end

      it { expect(subject).to set_flash[:danger].to(I18n.t('message.error.order_book.update_quantity')) }
    end
  end

  describe '#destroy' do
    before { delete :destroy, params: params }

    context 'when success' do
      let(:params) do
        { id: order_book.id }
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(subject).to set_flash[:success].to(I18n.t('message.success.order_book.delete')) }
      it { expect(response).to redirect_to(order_books_path) }
    end
  end
end
