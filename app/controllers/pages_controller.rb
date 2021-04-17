# frozen_string_literal: true

class PagesController < ApplicationController
  decorates_assigned :latest_books
  LATEST_BOOKS_QUANTITY = 3

  def index
    @latest_books = Book.last(LATEST_BOOKS_QUANTITY)
  end
end
