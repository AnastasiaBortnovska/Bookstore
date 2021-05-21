# frozen_string_literal: true

class BooksController < ApplicationController
  include Pagy::Backend

  decorates_assigned :books, :book

  def index
    @books_count = Book.count
    scoped_books = BooksQuery.new(params).call
    @pagy, @books = pagy_countless(scoped_books, link_extra: 'data-remote="true"')
    @presenter = BooksPresenter.new
  end

  def show
    @book = Book.find(params[:id])
  end
end
