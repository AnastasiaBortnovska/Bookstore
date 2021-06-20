# frozen_string_literal: true

RSpec.describe Admin::CategoriesController do
  describe 'not admin user is not allowed to access admin panel' do
    before { get :index }

    it { expect(subject).to redirect_to(admin_user_session_path) }
  end

  describe 'category CRUD' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:category) { create(:category) }

    let(:valid_attributes) { attributes_for :category }
    let(:invalid_attributes) { { name: nil } }

    render_views

    before { sign_in create(:admin_user) }

    describe '#index' do
      before { get :index }

      it { expect(subject).to respond_with(:ok) }
      it { expect(assigns(:categories)).to include(category) }
      it { expect(page).to have_content category.name }
    end

    describe '#new' do
      before { get :new }

      it { expect(subject).to respond_with(:ok) }
      it { expect(assigns(:category)).to be_a_new(Category) }
      it { expect(page).to have_field('category_name') }
    end

    describe '#create' do
      context 'with valid params' do
        it 'creates a new category' do
          expect do
            post :create, params: { category: valid_attributes }
          end.to change(Category, :count).by(1)
        end

        it 'assigns a newly created category as @category' do
          post :create, params: { category: valid_attributes }
          expect(assigns(:category)).to be_a(Category)
        end

        it 'redirects to the created category' do
          post :create, params: { category: valid_attributes }
          expect(subject).to respond_with(302)
          expect(response).to redirect_to admin_category_path(Category.last)
        end

        it 'creates the category' do
          post :create, params: { category: valid_attributes }
          expect(Category.last.name).to eq valid_attributes[:name]
        end
      end

      context 'with invalid params' do
        it 'invalid_attributes respond with 200' do
          post :create, params: { category: invalid_attributes }
          expect(subject).to respond_with(:ok)
        end

        it 'assigns a newly created but unsaved category as @category' do
          post :create, params: { category: invalid_attributes }
          expect(assigns(:category)).to be_a_new(Category)
        end

        it 'invalid_attributes do not create a category' do
          expect do
            post :create, params: { category: invalid_attributes }
          end.not_to change(Category, :count)
        end
      end
    end

    describe '#edit' do
      before { get :edit, params: { id: category.id } }

      it { expect(subject).to respond_with(:ok) }
      it { expect(assigns(:category)).to eq(category) }
      it { expect(page).to have_field('category_name') }
    end

    describe '#update' do
      context 'with valid params' do
        before { put :update, params: { id: category.id, category: valid_attributes } }

        it { expect(assigns(:category)).to eq(category) }

        it 'responds with 302' do
          expect(subject).to respond_with 302
          expect(response).to redirect_to(admin_category_path(category))
        end

        it 'updates the person' do
          category.reload
          expect(category.name).to eq valid_attributes[:name]
        end
      end
    end

    describe '#show' do
      before { get :show, params: { id: category.id } }

      it { expect(subject).to respond_with(:ok) }
      it { expect(assigns(:category)).to eq(category) }
      it { expect(page).to have_content(category.name) }
    end

    describe '#destroy' do
      it 'destroys the requested category' do
        expect do
          delete :destroy, params: { id: category.id }
        end.to change(Category, :count).by(-1)
      end

      it 'redirects to the field' do
        delete :destroy, params: { id: category.id }
        expect(response).to redirect_to(admin_categories_path)
      end
    end
  end
end
