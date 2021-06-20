# frozen_string_literal: true

require_relative 'book_review_form'
class ReviewPage < SitePrism::Page
  set_url '/books{/book_id}'

  element :title_reviews, 'h3', text: I18n.t('reviews.book_reviews.title_reviews')
  element :create_data, '.general-message-date'
  element :user_email, '.general-message-name'
  element :review_title, 'h4'
  element :review_body, 'p'
  element :div_success, 'div.alert.alert-success'

  section :review_form, BookReviewForm, 'form'
end
