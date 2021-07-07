# frozen_string_literal: true

ActiveAdmin.register Review do
  actions :index, :show

  scope :unprocessed
  scope(I18n.t('admin.reviews.processed')) { |scope| scope.where.not state: :unprocessed }

  config.filters = false

  index do
    selectable_column
    column :book
    column :title
    column t('admin.reviews.create_date'), :created_at
    column :user
    column :state
    actions
  end

  action_item :state, only: :show do
    link_to t('admin.reviews.approved'), publish_admin_review_path(review), method: :put unless review.approved?
  end

  action_item :state, only: :show do
    link_to t('admin.reviews.rejected'), unpublish_admin_review_path(review), method: :put unless review.rejected?
  end

  member_action :publish, method: :put do
    review = Review.find_by(id: params[:id])
    review ? review.update(state: :approved) : flash[:alert] = I18n.t('admin.reviews.errors.not_found_review')
    redirect_to admin_reviews_path
  end

  member_action :unpublish, method: :put do
    review = Review.find_by(id: params[:id])
    review ? review.update(state: :rejected) : flash[:alert] = I18n.t('admin.reviews.errors.not_found_review')
    redirect_to admin_reviews_path
  end
end
