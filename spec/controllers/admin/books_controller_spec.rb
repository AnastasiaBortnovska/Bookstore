# frozen_string_literal: true

RSpec.describe Admin::BooksController do
  describe 'not admin user is not allowed to access admin panel' do
    it do
      get :index
      expect(subject).to redirect_to(admin_user_session_path)
    end
  end

  describe 'book CRUD' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:book) { create(:book, :with_authors).decorate }

    render_views

    before do
      sign_in create(:admin_user)
    end

    describe 'GET index' do
      before { get :index }

      it 'responds with 200' do
        expect(subject).to respond_with(:ok)
      end

      it 'assigns the book' do
        expect(assigns(:books)).to include(book)
      end

      it 'renders the expected columns' do
        [book.category.name, book.title, book.authors_as_string, book.medium_description,
         book.price].each do |attribute|
          expect(page).to have_content(attribute)
        end
      end
    end

    describe 'GET new' do
      before { get :new }

      it 'responds with 200' do
        expect(subject).to respond_with(:ok)
      end

      it 'assigns the book' do
        expect(assigns(:book)).to be_a_new(Book)
      end

      it 'renders the form elements' do
        %w[book_title book_description book_price book_publication_year book_height book_width book_depth
           book_material].each do |field|
          expect(page).to have_field(field)
        end
      end
    end

    describe 'POST create' do
      let(:category) { create(:category) }
      let(:author) { create(:author) }
      let(:valid_attributes) { attributes_for(:book, category_id: category.id, authors_ids: [author.id]) }

      context 'with valid params' do
        it 'creates a new Book' do
          expect do
            post :create, params: { book: valid_attributes }
          end.to change(Book, :count).by(1)
        end

        it 'assigns a newly created book as @book' do
          post :create, params: { book: valid_attributes }
          expect(assigns(:book)).to be_a(Book)
        end

        it 'redirects to the created book' do
          post :create, params: { book: valid_attributes }
          expect(subject).to respond_with(302)
          expect(response).to redirect_to admin_book_path(Book.last)
        end

        it 'creates the book' do
          post :create, params: { book: valid_attributes }
          expect(Book.last.title).to eq valid_attributes[:title]
        end
      end
    end

    describe 'GET edit' do
      before do
        get :edit, params: { id: book.id }
      end

      it 'respond with 200' do
        expect(subject).to respond_with(:ok)
      end

      it 'assigns the book' do
        expect(assigns(:book)).to eq(book)
      end

      it 'renders the form elements' do
        %w[book_title book_description book_price book_publication_year book_height book_width book_depth
           book_material].each do |field|
          expect(page).to have_field(field)
        end
      end
    end

    describe 'PUT update' do
      let(:category) { create(:category) }
      let(:author) { create(:author) }
      let(:valid_attributes) { attributes_for(:book, category_id: category.id, authors_ids: [author.id]) }

      context 'with valid params' do
        before do
          put :update, params: { id: book.id, book: valid_attributes }
        end

        it 'assigns the book' do
          expect(assigns(:book)).to eq(book)
        end

        it 'responds with 302' do
          expect(subject).to respond_with(302)
          expect(response).to redirect_to(admin_book_path(book))
        end

        it 'updates the book' do
          book.reload
          expect(book.title).to eq valid_attributes[:title]
        end
      end
    end

    describe 'GET show' do
      before do
        get :show, params: { id: book.id }
      end

      it 'responds with 200' do
        expect(subject).to respond_with(:ok)
      end

      it 'assigns the book' do
        expect(assigns(:book)).to eq(book)
      end

      it 'renders the form elements' do
        [book.title, book.description, book.price, book.publication_year, book.height, book.height, book.width,
         book.depth, book.material].each do |attribute|
          expect(page).to have_content(attribute)
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested book' do
        expect do
          delete :destroy, params: { id: book.id }
        end.to change(Book, :count).by(-1)
      end

      it 'redirects to the field' do
        delete :destroy, params: { id: book.id }
        expect(response).to redirect_to(admin_books_path)
      end
    end
  end
end
