# frozen_string_literal: true

class Catalog < SitePrism::Page
  set_url '/books'

  elements :book_name, 'p.title'
  elements :authors, 'p'
  elements :book_wrapper, 'div.col-xs-6.col-sm-3'
  element :button_view_more, 'a', text: I18n.t('books.partials.next_page_link.button')
  elements :category, 'li.mr-35 a'
  elements :count_book_category, 'span.badge'
  element :show_filter, 'a.dropdown-toggle.lead.small', text: BooksPresenter::DEFAULT
  elements :filter, 'ul.dropdown-menu li'
end
