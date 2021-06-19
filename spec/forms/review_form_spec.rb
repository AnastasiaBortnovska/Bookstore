RSpec.describe ReviewForm, type: :model do

    describe 'presence validations' do
        it { is_expected.to validate_presence_of(:title) }
        it { is_expected.to validate_presence_of(:body) }
        it { is_expected.to validate_presence_of(:score) }
    end

    describe 'length validations' do
        it { is_expected.to validate_length_of(:title).is_at_most(ReviewForm::LENGTH[:title]) }
        it { is_expected.to validate_length_of(:body).is_at_most(ReviewForm::LENGTH[:body]) }
    end

    describe 'valid inputs' do
        let(:valid_text_input) { FFaker::Name.first_name }
        let(:valid_score) { rand(1..5)  }
    
        it { is_expected.to allow_value(valid_text_input).for(:title) }
        it { is_expected.to allow_value(valid_text_input).for(:body) }
        it { is_expected.to allow_value(valid_score).for(:score) }
    end

    describe '#save' do
        subject(:review_form) { described_class.new(params) }

        let(:user) { create(:user) }
        let(:book) { create(:book) }
        let(:params) { attributes_for(:review, user_id: user.id, book_id: book.id) }

        it 'success' do
            expect { review_form.save }.to change(Review, :count).by(1)
        end

        it 'fail' do
            allow(review_form).to receive(:valid?).and_return(false)
            expect { review_form.save }.to change(Review, :count).by(0)
        end
  end
end
