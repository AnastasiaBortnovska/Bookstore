class OrderCompletedMailerWorker
  include Sidekiq::Worker

  def perform(order_id)
    OrderMailer.completed_order(finded_order(order_id)).deliver
  end

  private

  def finded_order(order_id)
    Order.find_by(id: order_id)
  end
end
