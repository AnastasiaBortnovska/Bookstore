# frozen_string_literal: true

class BookPage < SitePrism::Page
  set_url '/books{/book_id}'

  element :link_to_back, 'a.general-back-link', text: I18n.t('books.show.buttons.back')
  element :book_name, 'h1'
  element :book_authors, 'p'
  element :book_price, 'p'
  element :btn_read_more, 'button', text: I18n.t('books.show.buttons.read_more')
  element :book_dimensions, 'p'
  element :book_all_description, 'span'
end
