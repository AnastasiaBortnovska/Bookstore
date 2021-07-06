# frozen_string_literal: true

class BookPhoto < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :book
end
