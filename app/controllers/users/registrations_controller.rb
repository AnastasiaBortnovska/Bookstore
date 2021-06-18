# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @billing_address = AddressForm.new(current_user.billing_address&.attributes)
    @shipping_address = AddressForm.new(current_user.shipping_address&.attributes)
    super
  end

  protected

  def update_resource(resource, params)
    params[:current_password] ? super : resource.update_without_password(params)
  end
end
