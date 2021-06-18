# frozen_string_literal: true

RSpec.describe Admin::AuthorsController do
  describe 'not admin user is not allowed to access admin panel' do
    it do
      get :index
      expect(subject).to redirect_to(admin_user_session_path)
    end
  end

  describe 'author CRUD' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:author) { create(:author) }
<<<<<<< HEAD
=======

>>>>>>> added spec
    let(:valid_attributes) { attributes_for :author }
    let(:invalid_attributes) { { name: nil } }

    render_views

<<<<<<< HEAD
    before { sign_in create(:admin_user) }

    describe '#index' do
      before { get :index }

      it { expect(subject).to respond_with(:ok) }
      it { expect(assigns(:authors)).to include(author) }

      it 'renders the expected columns' do
        [author.first_name, author.last_name, author.description].each do |field|
          expect(page).to have_content(field)
        end
      end
    end

    describe '#new' do
      before { get :new }

      it { expect(subject).to respond_with(:ok) }
      it { expect(assigns(:author)).to be_a_new(Author) }

      it 'renders the form elements' do
        %w[author_first_name author_last_name author_description].each do |field|
          expect(page).to have_field(field)
        end
      end
    end

    describe '#create' do
      before { post :create, params: { author: valid_attributes } }

      it { expect(assigns(:author)).to be_a(Author) }
      it { expect(subject).to respond_with(302) }
      it { expect(response).to redirect_to admin_author_path(Author.last) }
      it { expect(Author.last.first_name).to eq valid_attributes[:first_name] }
    end

    describe '#edit' do
=======
    before do
      sign_in create(:admin_user)
    end

    describe 'GET index' do
      before { get :index }

      it 'responds with 200' do
        expect(subject).to respond_with(:ok)
      end

      it 'assigns the author' do
        expect(assigns(:authors)).to include(author)
      end

      it 'renders the expected columns' do
        expect(page).to have_content(author.first_name)
        expect(page).to have_content(author.last_name)
        expect(page).to have_content(author.description)
      end
    end

    describe 'GET new' do
      before { get :new }

      it 'responds with 200' do
        expect(subject).to respond_with(:ok)
      end

      it 'assigns the author' do
        expect(assigns(:author)).to be_a_new(Author)
      end

      it 'renders the form elements' do
        expect(page).to have_field('author_first_name')
        expect(page).to have_field('author_last_name')
        expect(page).to have_field('author_description')
      end
    end

    describe 'POST create' do
      context 'with valid params' do
        it 'creates a new Author' do
          expect do
            post :create, params: { author: valid_attributes }
          end.to change(Author, :count).by(1)
        end

        it 'assigns a newly created author as @author' do
          post :create, params: { author: valid_attributes }
          expect(assigns(:author)).to be_a(Author)
        end

        it 'redirects to the created author' do
          post :create, params: { author: valid_attributes }
          expect(subject).to respond_with(302)
          expect(response).to redirect_to admin_author_path(Author.last)
        end

        it 'creates the author' do
          post :create, params: { author: valid_attributes }
          expect(Author.last.first_name).to eq valid_attributes[:first_name]
        end
      end
    end

    describe 'GET edit' do
>>>>>>> added spec
      before do
        get :edit, params: { id: author.id }
      end

<<<<<<< HEAD
      it { expect(subject).to respond_with(:ok) }
      it { expect(assigns(:author)).to eq(author) }
      it { expect(page).to have_field('author_last_name') }
    end

    describe '#update' do
      before { put :update, params: { id: author.id, author: valid_attributes } }

      it { expect(assigns(:author)).to eq(author) }
      it { expect(subject).to respond_with(302) }
      it { expect(response).to redirect_to(admin_author_path(author)) }

      it 'updates the person' do
        author.reload
        expect(author.first_name).to eq valid_attributes[:first_name]
      end
    end

    describe '#show' do
      before { get :show, params: { id: author.id } }

      it { expect(subject).to respond_with(:ok) }
      it { expect(assigns(:author)).to eq(author) }
      it { expect(page).to have_content(author.first_name) }
      it { expect(page).to have_content(author.last_name) }
    end

    describe '#destroy' do
      before { delete :destroy, params: { id: author.id } }

      it { expect(response).to redirect_to(admin_authors_path) }
=======
      it 'respond with 200' do
        expect(subject).to respond_with(:ok)
      end

      it 'assigns the author' do
        expect(assigns(:author)).to eq(author)
      end

      it 'renders the form elements' do
        expect(page).to have_field('author_first_name')
        expect(page).to have_field('author_last_name')
      end
    end

    describe 'PUT update' do
      context 'with valid params' do
        before do
          put :update, params: { id: author.id, author: valid_attributes }
        end

        it 'assigns the author' do
          expect(assigns(:author)).to eq(author)
        end

        it 'responds with 302' do
          expect(subject).to respond_with(302)
          expect(response).to redirect_to(admin_author_path(author))
        end

        it 'updates the person' do
          author.reload
          expect(author.first_name).to eq valid_attributes[:first_name]
        end
      end
    end

    describe 'GET show' do
      before do
        get :show, params: { id: author.id }
      end

      it 'responds with 200' do
        expect(subject).to respond_with(:ok)
      end

      it 'assigns the author' do
        expect(assigns(:author)).to eq(author)
      end

      it 'renders the form elements' do
        expect(page).to have_content(author.first_name)
        expect(page).to have_content(author.last_name)
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested author' do
        expect do
          delete :destroy, params: { id: author.id }
        end.to change(Author, :count).by(-1)
      end

      it 'redirects to the field' do
        delete :destroy, params: { id: author.id }
        expect(response).to redirect_to(admin_authors_path)
      end
>>>>>>> added spec
    end
  end
end
