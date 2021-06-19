RSpec.describe ReviewsController do
    let(:book) { create(:book) }
    let(:user) { create(:user) }
  
    before { sign_in(user) }
  
    describe 'POST create' do
      let(:params) do
        { review_form: attributes_for(:review, book_id: book.id, user_id: user.id) }
      end
  
      before { post :create, params: params }
  
      it 'return redirect response' do
        expect(response).to have_http_status(302)
      end
    end
end
