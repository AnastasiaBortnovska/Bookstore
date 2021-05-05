# frozen_string_literal: true

RSpec.describe BooksController do
  describe '#index' do
    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
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
  end

  describe '#show' do
    let(:book) { create(:book) }

    context 'with valid book_id' do
      before { get :show, params: { id: book.id } }

      it { expect(response).to render_template(:show) }

      it 'responds with success status' do
        expect(response.status).to eq(200)
      end

      it 'assigns @book' do
        expect(assigns(:book)).to eq book
      end
    end

    context 'when book not found' do
      before { get :show, params: { id: book.id.next } }

      it { expect(response).to render_template 'errors/404.html' }
      it { is_expected.to respond_with(:not_found) }
    end
  end
end
