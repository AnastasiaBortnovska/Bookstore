# frozen_string_literal: true

class BooksPresenter < Rectify::Presenter
  DEFAULT = I18n.t('get_category.filter_name.name_asc')
  def show_name_filter(filter_name)
    BooksQuery::BOOK_FILTERING_ORDER[filter_name] || DEFAULT
  end
end
