# frozen_string_literal: true

class BookDecorator < Draper::Decorator
  DESCRIPTION_LENGTH = 240
  DEFAULT_IMG = 'cover/default.jpg'
  decorates_association :authors, with: AuthorDecorator
  delegate_all

  def authors_as_string
    authors.map(&:full_name).join(', ')
  end

  def material_as_string
    material.capitalize
  end

  def dimensions
    I18n.t('decorator.dimensions', height: height, width: width, depth: depth)
  end

  def short_description
    description.split('.').first
  end

  def medium_description
    description[0..DESCRIPTION_LENGTH]
  end

  def all_description
    description[(DESCRIPTION_LENGTH.next)..]
  end

  def description_less_240?
    description.size < DESCRIPTION_LENGTH
  end

  def show_cover(size)
    return DEFAULT_IMG unless book.cover
    
    book.cover_derivatives!
    book.cover_url(size)
  end
end
