# frozen_string_literal: true

class BooksController < ApplicationController
  BOOKS_ON_PAGE = 12
  include Pagy::Backend

  decorates_assigned :books, :book

  def index
    @books_count = Book.all.count
    scoped_books = Books::GetCategory.new(params).call
    @pagy, @books = pagy_countless(scoped_books, items: BOOKS_ON_PAGE, link_extra: 'data-remote="true"')
    @filter_presenter = FilterPresenter.new
  end

  def show
    @book = Book.find(params[:id])
  end
end
