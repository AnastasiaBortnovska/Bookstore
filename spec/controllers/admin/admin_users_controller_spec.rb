# frozen_string_literal: true

RSpec.describe Admin::AdminUsersController do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:current_user) { create(:admin_user) }

  before { sign_in current_user }

  describe '#index' do
    before { get :index }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:admin_users)).to include(current_user) }
  end

  describe '#edit' do
    before { get :edit, params: { id: current_user.id } }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:admin_user)).to eq(current_user) }
  end
end
