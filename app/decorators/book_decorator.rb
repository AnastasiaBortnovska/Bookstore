# frozen_string_literal: true

class BookDecorator < Draper::Decorator
  DESCRIPTION_LENGTH = 240
  decorates_association :authors, with: AuthorDecorator
  delegate_all

  def authors_as_string
    authors.map(&:full_name).join(', ')
  end

  def material_as_string
    material.capitalize
  end

  def dimensions
    "H: #{height}\" x W: #{width}\" x D: #{depth}"
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
end
