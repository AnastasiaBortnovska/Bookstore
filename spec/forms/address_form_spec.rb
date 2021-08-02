# frozen_string_literal: true

RSpec.describe AddressForm, type: :model do
  let(:subject) { described_class.new(order) }
  let(:order) { create(:order, :with_user) }

  context 'when valid address' do
    let(:params) do
      { billing_address: attributes_for(:address) }
    end

    it { expect(subject.validate(params)).to eq true }
  end

  describe 'invalid address' do
    %i[first_name last_name city zip country address phone].each do |field|
      context "when #{field} is nil" do
        let(:params) do
          { billing_address: attributes_for(:address, field => nil) }
        end

        it { expect(subject.validate(params)).to eq false }
      end
    end

    %i[first_name last_name city country].each do |field|
      context "when wrong format #{field}" do
        let(:params) do
          { billing_address: attributes_for(:address, field => rand(100)) }
        end

        it { expect(subject.validate(params)).to eq false }
      end
    end

    %i[zip phone].each do |field|
      context "when wrong format #{field}" do
        let(:params) do
          { billing_address: attributes_for(:address, field => FFaker::Name.first_name) }
        end

        it { expect(subject.validate(params)).to eq false }
      end
    end
  end
end
