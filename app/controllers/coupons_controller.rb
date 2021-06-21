# frozen_string_literal: true

class CouponsController < ApplicationController
  before_action :apply_coupon

  def update; end

  private

  def apply_coupon
    if CouponsQuery.new(current_order, coupon_params).call
      flash[:success] = I18n.t('message.success.coupon.used')
    else
      flash[:danger] = I18n.t('message.error.coupon.used')
    end

    redirect_to request.referer || root_path
  end

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end
