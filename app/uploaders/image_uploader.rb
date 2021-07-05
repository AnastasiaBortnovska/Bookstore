# frozen_string_literal: true

require 'image_processing/mini_magick'

class ImageUploader < Shrine
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      small: magick.resize_to_limit!(160, 190),
      medium: magick.resize_to_limit!(250, 310),
      large: magick.resize_to_limit!(555, 380),
      for_images: magick.resize_to_limit!(170, 120)
    }
  end
end
