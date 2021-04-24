# frozen_string_literal: true

class FilterPresenter < Rectify::Presenter
  def show_name_filter(name_filter = nil)
    return Filtering::BOOK_FILTERING_ORDER[name_filter] if Filtering::BOOK_FILTERING_ORDER[name_filter]

    Filtering::DEFAULT
  end
end
