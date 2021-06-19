RSpec.describe Admin::ReviewsController do
  describe 'not admin user is not allowed to access admin panel' do
    it do
      get :index
      expect(subject).to redirect_to(admin_user_session_path)
    end
  end

  describe 'reviews actions' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:review) { create(:review) }

    render_views
    before do
      sign_in create(:admin_user)
    end

    describe 'GET index' do
      before { get :index }

      it 'responds with 200' do
        is_expected.to respond_with(:ok)
      end

      it 'renders the expected columns' do
        expect(page).to have_content(review.book.title)
        expect(page).to have_content(review.title)
        expect(page).to have_content(I18n.t('admin.reviews.create_date'))
        expect(page).to have_content(review.user.email)
        expect(page).to have_content(review.state)
      end
    end

    describe 'GET show' do
      before do
        get :show, params: { id: review.id }
      end

      it 'responds with 200' do
        is_expected.to respond_with(:ok)
      end

      it 'renders the form elements' do
        expect(page).to have_content(review.title)
        expect(page).to have_content(review.body)
        expect(page).to have_content(review.score)
        expect(page).to have_content(review.state)
        expect(page).to have_content(review.user.email)
        expect(page).to have_content(review.book.title)
      end
    end

    describe 'PUT publish' do
      before do
        put :publish, params: { id: review.id }
      end

      it 'responds with 302' do
        is_expected.to respond_with(302)
        expect(response).to redirect_to(admin_reviews_path)
      end

      it 'publishes the review' do
        review.reload
        expect(review.state).to eq(Review::STATE[:approved])
      end
    end

    describe 'PUT unpublish' do
      before do
        put :unpublish, params: { id: review.id }
      end

      it 'responds with 302' do
        is_expected.to respond_with(302)
        expect(response).to redirect_to(admin_reviews_path)
      end

      it 'unpublishes the review' do
        review.reload
        expect(review.state).to eq(Review::STATE[:rejected])
      end
    end
  end
end
