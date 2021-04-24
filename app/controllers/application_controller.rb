# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  protect_from_forgery

  def not_found
    render 'error/404.html', layout: false, status: :not_found
  end
end
