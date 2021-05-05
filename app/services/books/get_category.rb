# frozen_string_literal: true

class Books::GetCategory
  BOOK_FILTERING_ORDER = {
    'name ASC' => I18n.t('get_category.filter_name.name_asc'),
    'name DESC' => I18n.t('get_category.filter_name.name_desc'),
    'created_at DESC' => I18n.t('get_category.filter_name.created_at_desc'),
    'price ASC' => I18n.t('get_category.filter_name.price_asc'),
    'price DESC' => I18n.t('get_category.filter_name.price_desc')
  }.freeze
  DEFAULT_SORT = BOOK_FILTERING_ORDER.first

  def initialize(params = {})
    @category_id = params[:category_id]
    @sort_by_param = params[:sort_by]
  end

  def call
    sort_by_param_valid? ? select_books.order(@sort_by_param) : select_books.order(DEFAULT_SORT[0])
  end

  private

  def sort_by_param_valid?
    BOOK_FILTERING_ORDER.include?(@sort_by_param)
  end

  def category_id_valid?
    Category.where(id: @category_id).any?
  end

  def select_books
    books = Book.all
    category_id_valid? ? books.where(category_id: @category_id) : books
  end
end
