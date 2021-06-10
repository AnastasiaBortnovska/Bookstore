# frozen_string_literal: true

RSpec.describe AddressesController do
  let(:user) { create(:user) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe '#create' do
    let(:address_params) do
      { address_form: attributes_for(:address, address_type: 'billing') }
    end

    before { post :create, params: address_params }

    it 'return redirect response' do
      expect(response).to have_http_status(:found)
    end
  end

  describe '#update' do
    let(:address) { create(:address, :billing, addressable: user) }
    let(:address_params) do
      { address_form: attributes_for(:address), id: address.id }
    end

    before { put :update, params: address_params }

    it 'return redirect response' do
      expect(response).to have_http_status(:found)
    end
  end
end
