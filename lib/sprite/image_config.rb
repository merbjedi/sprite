module Sprite
  class ImageConfig
    def initialize(image_info, global_config_info)
      @image_info = image_info
      @global_config_info = global_config_info
    end

    def sources
      @image_info['sources'].to_a
    end

    def name
      @image_info['name']
    end

    def format
      @image_info['format'] || @global_config_info["default_format"]
    end

    def quality
      @image_info['quality'] || @global_config_info["default_quality"]
    end

    def background_color
      @image_info['background_color'] || @global_config_info["default_background_color"]
    end

    def spaced_by
      @image_info['spaced_by'] || @global_config_info["default_spacing"] || 0
    end

    def resize_to
      @image_info['resize_to'] || @global_config_info['resize_to']
    end

    def horizontal_layout?
      @image_info['align'].to_s == 'horizontal'
    end
  end
end