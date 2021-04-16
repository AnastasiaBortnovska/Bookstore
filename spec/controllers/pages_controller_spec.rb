# frozen_string_literal: true

RSpec.describe PagesController do
  describe 'GET /index' do
    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end
  end
end
