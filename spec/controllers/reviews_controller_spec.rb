# frozen_string_literal: true

RSpec.describe ReviewsController do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#create' do
    before { post :create, params: params }

    context 'when success' do
      let(:params) do
        { review_form: attributes_for(:review, book_id: book.id, user_id: user.id) }
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to(root_path) }
      it { expect(Review.count).to eq(1) }
      it { is_expected.to set_flash[:success].to(I18n.t('message.success.review.create')) }
    end

    context 'when failure' do
      let(:params) do
        { review_form: attributes_for(:review, title: nil, book_id: book.id, user_id: user.id) }
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to(root_path) }
      it { expect(Review.count).to be_zero }
      it { is_expected.to set_flash[:danger] }
    end
  end
end
