RSpec.describe AddressForm, type: :model do
  let(:subject) {described_class.new(order)}
  let(:order) { create(:order, :with_user) }
  
  context 'when valid address' do
    let(:params) do
      {billing_address: attributes_for(:address)}
    end

    it { expect(subject.validate(params)).to eq true}
  end

  context 'when invalid address' do
    let(:params) do
      {billing_address: attributes_for(:address, first_name: nil)}
    end

    it { expect(subject.validate(params)).to eq false}
  end

end
