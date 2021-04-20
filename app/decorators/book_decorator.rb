# frozen_string_literal: true

class BookDecorator < Draper::Decorator
  delegate_all

  def authors_as_string
    authors.map(&:name).join(', ')
  end

  def material_as_string
    material.capitalize
  end

  def short_description
    description.split('.').first
  end

  def medium_description
    description[0..240]
  end

  def all_description
    description[241..]
  end

  def description_less_240?
    description.size < 240
  end
end
