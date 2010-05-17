module Sprite
  class ImageReader
    def self.read(image_filename)
      # avoid loading rmagick till the last possible moment
      begin
        require "RMagick"
      rescue LoadError
        require 'rmagick'
      end

      Magick::Image::read(image_filename).first
    end
  end
end
