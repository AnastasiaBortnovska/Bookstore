class ReviewsController < ApplicationController

  def create
    review = ReviewForm.new(review_params)
    if review.save
      flash[:success] = t('message.success.review.create')
    else
      flash[:danger] = review.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end

  private

  def review_params
    params.require(:review_form).permit(:title, :body, :score, :book_id, :user_id)
  end
end
