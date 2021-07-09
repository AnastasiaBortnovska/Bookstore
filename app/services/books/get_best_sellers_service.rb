class Books::GetBestSellersService
  BEST_SELLERS_QUANTITY = 4

  def call
    Book.find(
      Order.completed.joins(:order_books).group(:book_id).order('sum("order_books"."quantity") DESC').count.keys
    ).first(BEST_SELLERS_QUANTITY)
  end
end
