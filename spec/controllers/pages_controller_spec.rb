# frozen_string_literal: true

RSpec.describe PagesController do
  describe 'GET /index' do
    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'assingns' do
    let!(:books) { create_list(:book, 2) }

    before do
      stub_const('PagesController::LATEST_BOOKS_QUANTITY', 1)
      get :index
    end

    it 'assingns @latest_books' do
      expect(assigns(:latest_books)).to match_array(books.last(PagesController::LATEST_BOOKS_QUANTITY))
    end
  end
end
