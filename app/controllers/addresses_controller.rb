# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :manage_address

  def create; end

  def update; end

  private

  def manage_address
    @form = AddressForm.new(address_params)
    @form.save ? show_success_message : show_failure_message
  end

  def show_success_message
    flash[:success] = t('message.success.address.update', type: address_params[:type].capitalize)
    redirect_to edit_user_registration_path(current_user)
  end

  def show_failure_message
    render 'devise/registrations/edit', locals: billing_address? ? billing_erorr_params : shipping_error_params
  end

  def billing_address?
    address_params[:type] == 'billing_address'
  end

  def billing_erorr_params
    { billing_address: @form, shipping_address: AddressForm.new(current_user.shipping_address&.attributes) }
  end

  def shipping_error_params
    { shipping_address: @form, billing_address: AddressForm.new(current_user.billing_address&.attributes) }
  end

  def address_params
    params.require(:address_form).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone,
                                         :type).merge(object: current_user)
  end
end
