# frozen_string_literal: true

RSpec.describe Admin::ReviewsController do
  describe 'not admin user is not allowed to access admin panel' do
    before { get :index }

    it { expect(subject).to redirect_to(admin_user_session_path) }
  end

  describe 'reviews actions' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:review) { create(:review) }

    render_views
    before { sign_in create(:admin_user) }

    describe '#index' do
      before { get :index }

      it { is_expected.to respond_with(:ok) }

      it 'renders the expected columns' do
        [review.book.title, review.title, review.user.email, review.state].each do |field|
          expect(page).to have_content(field)
        end
      end
    end

    describe '#show' do
      before { get :show, params: { id: review.id } }

      it { is_expected.to respond_with(:ok) }

      it 'renders the form elements' do
        [review.title, review.body, review.score, review.state, review.user.email, review.book.title].each do |field|
          expect(page).to have_content(field)
        end
      end
    end

    describe 'PUT publish' do
      before { put :publish, params: { id: review.id } }

      it 'responds with 302' do
        expect(subject).to respond_with(302)
        expect(response).to redirect_to(admin_reviews_path)
      end

      it 'publishes the review' do
        review.reload
        expect(review.state).to eq(Review::STATE[:approved])
      end
    end

    describe 'PUT unpublish' do
      before { put :unpublish, params: { id: review.id } }

      it 'responds with 302' do
        expect(subject).to respond_with(302)
        expect(response).to redirect_to(admin_reviews_path)
      end

      it 'unpublishes the review' do
        review.reload
        expect(review.state).to eq(Review::STATE[:rejected])
      end
    end
  end
end
