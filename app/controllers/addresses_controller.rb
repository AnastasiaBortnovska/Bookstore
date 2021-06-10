# frozen_string_literal: true

class AddressesController < ApplicationController
  load_and_authorize_resource

  before_action :manage_address

  def create; end

  def update; end

  private

  def manage_address
    address_form = AddressForm.new(address_params)
    address_form.save(current_user) ? show_success_message : show_failure_message(address_form)
    redirect_to edit_user_registration_path(current_user)
  end

  def show_success_message
    flash[:success] = t('message.success.address.update', type: address_params[:address_type].capitalize)
  end

  def show_failure_message(form)
    flash[:danger] = form.errors.full_messages.to_sentence
  end

  def address_params
    params.require(:address_form).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone,
                                         :address_type)
  end
end
