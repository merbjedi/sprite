module Sprite
  class ImageReader
    def self.read(image_filename)
      # avoid loading rmagick till the last possible moment
      require 'rmagick'

      Magick::Image::read(image_filename).first
    end
  end
end
