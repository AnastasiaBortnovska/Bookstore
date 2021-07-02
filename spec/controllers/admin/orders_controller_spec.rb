RSpec.describe Admin::OrdersController do
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:order) { create(:order).decorate }

  render_views
  before { sign_in create(:admin_user) }

    describe '#index' do
      before { get :index }

      it { is_expected.to respond_with(:ok) }

      it 'renders the expected columns' do
        [order.number, order.creation_date, order.status].each do |field|
          expect(page).to have_content(field)
        end
      end
    end

    describe '#edit' do
      before { get :edit, params: { id: order.id } }

      it { expect(subject).to respond_with(:ok) }
      it { expect(assigns(:order)).to eq(order) }
      it { expect(page).to have_field('order_status') }
    end

    describe '#update' do
      before { put :update, params: { id: order.id, status: Order.statuses.keys[4] } }

      it { expect(assigns(:order)).to eq(order) }

      it 'updates status' do
        category.reload
        expect(order.status).to eq Order.statuses.keys[4] }
      end
    end
end
