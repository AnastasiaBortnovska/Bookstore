# frozen_string_literal: true

class PagesController < ApplicationController
  
  LATEST_BOOKS_QUANTITY = 3

  def index
    @latest_books = BookDecorator.decorate_collection(Book.last(LATEST_BOOKS_QUANTITY))
  end
end
