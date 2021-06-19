RSpec.describe Review do
    describe 'associations' do
        it { is_expected.to belong_to(:book) }
        it { is_expected.to belong_to(:user) }
    end

    describe 'scopes' do
        it { expect(Review.unprocessed).to eq(Review.where(state: Review::STATE[:unprocessed])) }    
        it { expect(Review.approved).to eq(Review.where(state: Review::STATE[:approved])) }
        it { expect(Review.rejected).to eq(Review.where(state: Review::STATE[:rejected])) }
    end

    describe 'validations' do
        it { is_expected.to validate_presence_of(:title) }
        it { is_expected.to validate_presence_of(:body) }
    end
    
end
