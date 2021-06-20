ActiveAdmin.register Review do

  actions :index, :show

  scope I18n.t('admin.reviews.unprocessed'), :unprocessed
  scope(I18n.t('admin.reviews.processed')) { |scope| scope.where.not state: Review::STATE[:unprocessed] }

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
    link_to t('admin.reviews.approve'), publish_admin_review_path(review), method: :put unless review.state == Review::STATE[:approved] 
  end

  action_item :state, only: :show do
    link_to t('admin.reviews.rejecte'), unpublish_admin_review_path(review), method: :put unless review.state == Review::STATE[:rejected]
  end

  member_action :publish, method: :put do
    review = Review.find_by(id: params[:id])
    review.update(state: Review::STATE[:approved])
    redirect_to admin_reviews_path
  end

  member_action :unpublish, method: :put do
    review = Review.find_by(id: params[:id])
    review.update(state: Review::STATE[:rejected])
    redirect_to admin_reviews_path
  end
  
end
