# frozen_string_literal: true

RSpec.describe Admin::AuthorsController do
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:author) { create(:author) }
  let(:valid_attributes) { attributes_for :author }
  let(:invalid_attributes) { { name: nil } }

  render_views

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
    it { expect(subject).to respond_with(:found) }
    it { expect(response).to redirect_to admin_author_path(Author.last) }
    it { expect(Author.last.first_name).to eq valid_attributes[:first_name] }
  end

  describe '#edit' do
    before do
      get :edit, params: { id: author.id }
    end

    it { expect(subject).to respond_with(:ok) }
    it { expect(assigns(:author)).to eq(author) }
    it { expect(page).to have_field('author_last_name') }
  end

  describe '#update' do
    before { put :update, params: { id: author.id, author: valid_attributes } }

    it { expect(assigns(:author)).to eq(author) }
    it { expect(subject).to respond_with(:found) }
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
  end
end
