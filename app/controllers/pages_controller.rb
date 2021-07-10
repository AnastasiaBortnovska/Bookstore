# frozen_string_literal: true

class PagesController < ApplicationController
  decorates_assigned :best_sellers

  LATEST_BOOKS_QUANTITY = 3

  def index
    @latest_books = BookDecorator.decorate_collection(Book.last(LATEST_BOOKS_QUANTITY))
    @best_sellers = Books::GetBestSellersService.new.call
  end
end
