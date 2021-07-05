# frozen_string_literal: true

RSpec.describe CreditCardForm, type: :model do
  let(:subject) { described_class.new(order) }
  let(:order) { create(:order, :with_credit_card) }

  context 'when valid credit card' do
    let(:params) do
      { credit_card: attributes_for(:credit_card) }
    end

    it { expect(subject.validate(params)).to eq true }
  end

  describe 'invalid credit card' do
    %i[number name cvv expire_date].each do |field|
      context "when #{field} is nil" do
        let(:params) do
          { credit_card: attributes_for(:credit_card, field => nil) }
        end

        it { expect(subject.validate(params)).to eq false }
      end
    end

    %i[name expire_date].each do |field|
      context "when wrong format #{field}" do
        let(:params) do
          { credit_card: attributes_for(:credit_card, field => rand(100)) }
        end

        it { expect(subject.validate(params)).to eq false }
      end
    end

    %i[number cvv].each do |field|
      context "when wrong format #{field}" do
        let(:params) do
          { credit_card: attributes_for(:credit_card, field => FFaker::Name.first_name) }
        end

        it { expect(subject.validate(params)).to eq false }
      end
    end

    context 'when number length is less 16' do
      let(:params) do
        { credit_card: attributes_for(:credit_card, number: rand(9).to_s * 10) }
      end

      it { expect(subject.validate(params)).to eq false }
    end

    context 'when number length is more 16' do
      let(:params) do
        { credit_card: attributes_for(:credit_card, number: rand(9).to_s * 18) }
      end

      it { expect(subject.validate(params)).to eq false }
    end

    context 'when cvv length is more 4' do
      let(:params) do
        { credit_card: attributes_for(:credit_card, cvv: rand(9).to_s * 5) }
      end

      it { expect(subject.validate(params)).to eq false }
    end
  end
end
