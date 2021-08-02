# frozen_string_literal: true

class OrderItem < SitePrism::Section
  element :image, 'img'
  element :link_book_title, 'a'
  element :book_price, 'span'
  element :sub_total, 'span'
  element :delete_item_button, 'a.close'
end
