# frozen_string_literal: true

RSpec.describe BooksController do
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
    let!(:books) { create_list(:book, 3) }

    before { get :index }

    it 'assingns @books' do
      expect(assigns(:books)).to eq(books.sort_by(&:name))
    end

    it 'assingns @books_count' do
      expect(assigns(:books_count)).to eq(books.count)
    end
  end

  describe 'get show' do
    let(:book) { create(:book) }

    before { get :show, params: { id: book.id } }

    it { expect(response).to render_template :show }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns @book' do
      expect(assigns(:book)).to eq book
    end
  end

  describe 'get show wrong book_id' do
    let(:book) { create(:book) }

    before { get :show, params: { id: book.id.next } }

    it { expect(response).to render_template 'error/404.html' }

    it 'responds with success status' do
      expect(response.status).to eq(404)
    end
  end
end
