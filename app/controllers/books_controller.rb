# frozen_string_literal: true

class BooksController < ApplicationController
  BOOKS_ON_PAGE = 3

  include Filtering

  decorates_assigned :books, :book

  def index
    @books_count = Book.all.count
    scoped_books = Books::GetCategory.new(Book.all, params).call
    @books = scoped_books.paginate(page: params[:page], per_page: BOOKS_ON_PAGE)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
