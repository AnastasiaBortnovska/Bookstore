# frozen_string_literal: true

class BooksController < ApplicationController
  BOOKS_ON_PAGE = 12

  include Pagy::Backend
  include Filtering

  decorates_assigned :books, :book

  def index
    @books_count = Book.all.count
    @scoped_books = Books::GetCategory.new(Book.all, params).call
    @pagy, @books = pagy(@scoped_books, items: BOOKS_ON_PAGE)
  end

  def show
    @book = Book.find(params[:id])
  end
end
