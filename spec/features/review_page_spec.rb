# frozen_string_literal: true

RSpec.describe ReviewPage do
  let!(:review) { create(:review, :approved) }

  let(:book_review) { described_class.new }

  shared_examples 'review informations' do
    it { expect(book_review).to have_title_reviews }
    it { expect(book_review).to have_review_title(text: review.title) }
    it { expect(book_review).to have_review_body(text: review.body) }
    it { expect(book_review).to have_create_data(text: I18n.l(review.created_at, format: :slash_date_format)) }
    it { expect(book_review).to have_user_email(text: review.user.email) }
  end

  describe 'when user log in' do
    let!(:user) { create(:user) }

    let(:params) { attributes_for(:review) }
    let(:invalid_params) { attributes_for(:review, title: '') }

    before do
      login_as(user, scope: :user)
      book_review.load(book_id: review.book.id)
    end

    it { expect(book_review).to have_review_form }

    include_examples 'review informations'

    it 'failurefully fill form' do
      book_review.review_form.fill_in(invalid_params)
      expect(book_review).not_to have_div_success(text: I18n.t('message.success.review.create'))
    end

    it 'successfully fill form' do
      book_review.review_form.fill_in(params)
      expect(book_review).to have_div_success(text: I18n.t('message.success.review.create'))
    end
  end

  describe 'when user log out' do
    before { book_review.load(book_id: review.book.id) }

    it { expect(book_review).not_to have_review_form }

    include_examples 'review informations'
  end
end
