# frozen_string_literal: true

class Books::GetCategory
  include Filtering
  DEFAULT_SORT = 'name ASC'

  def initialize(params = {})
    @books = Book.all
    @category_id = params[:category_id]
    @sort_by_param = params[:sort_by]
  end

  def call
    select_books = @category_id ? @books.where(category_id: @category_id) : @books
    sort_by_param_valid? ? select_books.order(@sort_by_param) : select_books.order(DEFAULT_SORT)
  end

  private

  def sort_by_param_valid?
    BOOK_FILTERING_ORDER.include?(@sort_by_param)
  end
end
