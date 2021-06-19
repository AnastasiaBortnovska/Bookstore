# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :build_addresses, only: %i[edit]

  def edit; end

  protected

  def update_resource(resource, params)
    params[:current_password] ? super : resource.update_without_password(params)
  end

  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  def build_addresses
    redirect_to edit_user_registration_path if resource.blank?
    resource.build_billing_address if resource.billing_address.blank?
    resource.build_shipping_address if resource.shipping_address.blank?
  end
end
