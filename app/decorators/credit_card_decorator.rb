# frozen_string_literal: true

class CreditCardDecorator < Draper::Decorator
  delegate_all

  def masked_number
    "** ** ** #{number.last(4)}"
  end
end
