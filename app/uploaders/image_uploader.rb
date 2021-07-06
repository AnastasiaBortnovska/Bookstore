# frozen_string_literal: true

require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :validation_helpers
  plugin :determine_mime_type

  Attacher.validate do
    validate_max_size 5.megabytes
    validate_mime_type %w[image/jpeg image/png]
  end

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
