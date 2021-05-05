# frozen_string_literal: true

class BooksController < ApplicationController
  include Pagy::Backend
  Pagy::VARS[:items] = 12

  decorates_assigned :books, :book

  def index
    @books_count = Book.count
    scoped_books = Books::GetCategory.new(params).call
    @pagy, @books = pagy_countless(scoped_books, link_extra: 'data-remote="true"')
    @filter_presenter = FilterPresenter.new
    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
  end
end
