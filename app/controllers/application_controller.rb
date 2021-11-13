# frozen_string_literal: true

class ApplicationController < ActionController::Base
  DEFAULT_ORDER_BOOK = 0
  before_action :remote_ip
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  helper_method :categories
  helper_method :current_order
  helper_method :order_books_count
  protect_from_forgery

  def remote_ip
    fi = request.env['HTTP_X_FORWARDED_FOR']&.split(',')&.first
    flash[:success] = "F: #{fi}, S: #{request.remote_ip}"
  end

  def current_order
    @current_order ||= Order.find_by(id: session[:order_id]) if session[:order_id]
  end

  def order_books_count
    return DEFAULT_ORDER_BOOK unless current_order

    OrderBooks::BooksCountService.new(current_order).call
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:email, :password, :password_confirmation, :current_password,
                  shipping_address_attributes: %i[first_name last_name address city zip country phone],
                  billing_address_attributes: %i[first_name last_name address city zip country phone])
    end
  end

  private

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def categories
    Rails.cache.fetch('all_categories') { Category.all }
  end

  def not_found
    render 'errors/404.html', layout: false, status: :not_found
  end
end
