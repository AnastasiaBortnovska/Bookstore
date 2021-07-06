# frozen_string_literal: true

RSpec.describe Admin::BooksController do
  let!(:book) { create(:book, :with_authors).decorate }

  let(:page) { Capybara::Node::Simple.new(response.body) }

  render_views

  before { sign_in create(:admin_user) }

  describe '#index' do
    before { get :index }

    it { expect(subject).to respond_with(:ok) }
    it { expect(assigns(:books)).to include(book) }

    it 'renders the expected columns' do
      [book.category.name, book.title, book.authors_as_string, book.medium_description,
       book.price].each do |attribute|
        expect(page).to have_content(attribute)
      end
    end
  end

  describe '#new' do
    before { get :new }

    it { expect(subject).to respond_with(:ok) }
    it { expect(assigns(:book)).to be_a_new(Book) }

    %w[book_title book_description book_price book_publication_year book_height book_width book_depth
       book_material].each do |field|
      it "renders #{field}" do
        expect(page).to have_field(field)
      end
    end
  end

  describe '#create' do
    let(:category) { create(:category) }
    let(:author) { create(:author) }
    let(:valid_attributes) { attributes_for(:book, category_id: category.id, authors_ids: [author.id]) }

    context 'with valid params' do
      before { post :create, params: { book: valid_attributes } }

      it { expect(assigns(:book)).to be_a(Book) }
      it { expect(Book.last.title).to eq valid_attributes[:title] }

      it 'redirects to the created book' do
        post :create, params: { book: valid_attributes }
        expect(subject).to respond_with(:found)
        expect(response).to redirect_to admin_book_path(Book.last)
      end
    end
  end

  describe '#edit' do
    before { get :edit, params: { id: book.id } }

    it { expect(subject).to respond_with(:ok) }

    it { expect(assigns(:book)).to eq(book) }

    %w[book_title book_description book_price book_publication_year book_height book_width book_depth
       book_material].each do |field|
      it "renders the #{field} element" do
        expect(page).to have_field(field)
      end
    end
  end

  describe '#update' do
    let(:category) { create(:category) }
    let(:author) { create(:author) }
    let(:valid_attributes) { attributes_for(:book, category_id: category.id, authors_ids: [author.id]) }

    context 'with valid params' do
      before { put :update, params: { id: book.id, book: valid_attributes } }

      it { expect(assigns(:book)).to eq(book) }

      it 'responds with 302' do
        expect(subject).to respond_with(:found)
        expect(response).to redirect_to(admin_book_path(book))
      end

      it 'updates the book' do
        book.reload
        expect(book.title).to eq valid_attributes[:title]
      end
    end
  end

  describe '#show' do
    before { get :show, params: { id: book.id } }

    it { expect(subject).to respond_with(:ok) }
    it { expect(assigns(:book)).to eq(book) }

    it 'renders the form elements' do
      [book.title, book.description, book.price, book.publication_year, book.height, book.height, book.width,
       book.depth, book.material].each do |attribute|
        expect(page).to have_content(attribute)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the requested book' do
      expect { delete(:destroy, params: { id: book.id }) }.to change(Book, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: book.id }
      expect(response).to redirect_to(admin_books_path)
    end
  end
end
