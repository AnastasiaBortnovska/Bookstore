# frozen_string_literal: true

class CouponForm < SitePrism::Section
  element :input_coupon_code, '#coupon_code'
  element :button, 'input[type="submit"]'

  def fill_in(code)
    input_coupon_code.set(code)
    button.click
  end
end
