# frozen_string_literal: true

class BooksQuery
  BOOK_FILTERING_ORDER = {
    'title ASC' => I18n.t('get_category.filter_name.name_asc'),
    'title DESC' => I18n.t('get_category.filter_name.name_desc'),
    'created_at DESC' => I18n.t('get_category.filter_name.created_at_desc'),
    'price ASC' => I18n.t('get_category.filter_name.price_asc'),
    'price DESC' => I18n.t('get_category.filter_name.price_desc')
  }.freeze
  DEFAULT_SORT = 'title ASC'

  def initialize(params = {})
    @category_id = params[:category_id]
    @sort_by = params[:sort_by]
  end

  def call
    books.order(order_by)
  end

  private

  def order_by
    sort_by_param_valid? ? @sort_by : DEFAULT_SORT
  end

  def sort_by_param_valid?
    BOOK_FILTERING_ORDER.include?(@sort_by)
  end

  def books
    select_books = Book.where(category_id: @category_id)
    select_books.empty? ? Book.all : select_books
  end
end
