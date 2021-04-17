# frozen_string_literal: true

class Books::GetCategory
  DEFAULT_SORT = 'name ASC'

  def initialize(books, params)
    @books = books
    @category_id = params[:category_id]
    @sort_by_param = params[:sort_by]
  end

  def call
    select_books = @category_id ? Category.find(@category_id).books : @books
    @sort_by_param ? select_books.order(@sort_by_param) : select_books.order(DEFAULT_SORT)
  end
end
