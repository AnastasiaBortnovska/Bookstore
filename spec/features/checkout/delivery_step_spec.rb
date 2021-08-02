# frozen_string_literal: true

RSpec.describe Checkout::DeliveryStep do
  let!(:order) { create(:order, :with_item) }
  let!(:deliveries) { create_list(:delivery, 2) }

  let(:delivery_step) { described_class.new }
  let(:user) { create(:user, orders: [order]) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order)
    login_as(user, scope: :user)
    delivery_step.load
  end

  it { expect(delivery_step).to be_all_there }

  it 'delivery atributtes present' do
    deliveries.each do |delivery|
      expect(delivery_step).to have_delivery_name(text: delivery.name)
      expect(delivery_step).to have_delivery_days(text: delivery.days)
      expect(delivery_step).to have_delivery_price(text: delivery.price)
    end
  end

  context 'when select delivery method click button save_and_continue' do
    before do
      delivery_step.delivery_name(text: deliveries.first.name).click
      delivery_step.button_save_and_continue.click
    end

    it { expect(Checkout::PaymentStep.new).to be_displayed }
  end
end
