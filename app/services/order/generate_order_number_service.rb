# frozen_string_literal: true

class Order::GenerateOrderNumberService
  NUMBER_PREFIX = '#R'

  def call
    NUMBER_PREFIX + I18n.l(Time.zone.now, format: :order_create_date)
  end
end
