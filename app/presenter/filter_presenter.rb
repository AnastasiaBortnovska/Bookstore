# frozen_string_literal: true

class FilterPresenter < Rectify::Presenter
  def show_name_filter(name_filter = nil)
    if Books::GetCategory::BOOK_FILTERING_ORDER[name_filter]
      return Books::GetCategory::BOOK_FILTERING_ORDER[name_filter]
    end

    Books::GetCategory::DEFAULT_SORT[1]
  end
end
