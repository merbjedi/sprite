module Sprite
  class ImageResizer
    def initialize(resize_to)
      if resize_to
        @resizing = true
        @target_width, @target_height = *(resize_to.split('x').map(&:to_i))
      end
    end
    
    def resize(image)
      if @resizing
        needs_resizing = image.columns != @target_width || image.rows != @target_height
        if needs_resizing
          image.scale!(@target_width, @target_height)
        end
      end
    end
  end
end