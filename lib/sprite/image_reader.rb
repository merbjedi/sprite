module Sprite
  class ImageReader
    def self.read(image_filename)
      image = Magick::Image::read(image_filename).first
      image
    end
  end
end