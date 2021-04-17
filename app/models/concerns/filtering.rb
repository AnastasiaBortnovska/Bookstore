# frozen_string_literal: true

module Filtering
  BOOK_FILTERING_ORDER = {
    'name ASC' => 'Title A-Z',
    'name DESC' => 'Title Z-A',
    'created_at DESC' => 'Newest first',
    'price ASC' => 'Price: Low to high',
    'price DESC' => 'Price: High to low'
  }.freeze
end
