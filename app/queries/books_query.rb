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
    @sort_by_param = params[:sort_by]
  end

  def call
    books.order(order_by)
  end

  private

  def order_by
    sort_by_param_valid? ? @sort_by_param : DEFAULT_SORT
  end

  def sort_by_param_valid?
    BOOK_FILTERING_ORDER.include?(@sort_by_param)
  end

  def category_id_valid?
    Category.where(id: @category_id).any?
  end

  def books
    category_id_valid? ? Book.where(category_id: @category_id) : Book.all
  end
end
