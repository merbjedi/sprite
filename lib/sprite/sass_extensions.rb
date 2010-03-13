module Sprite
  module Sass
    module Extensions
      def sprite_background(group, image)
        sprite = sprite_data(group, image)
        if sprite
          sprite_path = sprite_builder.image_path(group.value)
          "url('#{sprite_path}') no-repeat #{sprite[:x]}px #{sprite[:y]}px"
        else
          ""
        end
      end

      def sprite_width(group, image)
        sprite = sprite_data(group, image)
        if sprite
          "#{sprite[:width]}px"
        else
          ""
        end
      end
      
      def sprite_height(group, image)
        sprite = sprite_data(group, image)
        if sprite
          "#{sprite[:height]}px"
        else
          ""
        end
      end
      
      protected
      def sprite_builder
        @__sprite_builder ||= Builder.from_config
      end

      def sprite_data(group, image)
        unless @__sprite_data
          sprite_data_path = sprite_builder.style_output_path
          
          # read sprite data from yml
          @__sprite_data = File.open(sprite_data_path) { |yf| YAML::load( yf ) }
        end
        
        group_data = @__sprite_data[group.to_s]
        if group_data
          return group_data[image.to_s]
        else
          nil
        end
      end
      
    end
  end
end

if defined?(Sass)
  module Sass::Script::Functions
    include Sprite::Sass::Extensions
  end
end
