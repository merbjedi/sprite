module Sprite
  module Sass
    module Extensions
      def sprite_background(group, image)
        sprite = sprite_data(group, image)
        if sprite
          sprite_path = sprite_builder.image_path(group.value)
          ::Sass::Script::String.new "url('#{sprite_path}') no-repeat #{sprite[:x]}px #{sprite[:y]}px"
        else
          ::Sass::Script::String.new ""
        end
      end

      def sprite_width(*args)
        ::Sass::Script::String.new sprite_attr(:width, *args)
      end

      def sprite_height(*args)
        ::Sass::Script::String.new sprite_attr(:height, *args)
      end

      def sprite_x_offset(*args)
        ::Sass::Script::String.new sprite_attr(:x, *args)
      end

      def sprite_y_offset(*args)
        ::Sass::Script::String.new sprite_attr(:y, *args)
      end

      def sprite_image(group)
        ::Sass::Script::String.new sprite_builder.image_path(group.value)
      end

      def sprite_url(group)
        ::Sass::Script::String.new "url('#{sprite_image(group)}')"
      end

      ##
      # Return a sprite offset for the given image.  When the optional x and y values are passed,
      # numeric values are treated as additional offsets to the sprite image offset.  Any string
      # values are treated as replacement offsets.
      #
      # Examples:
      # * sprite_offset("common", "icon", "100%", 5) => offset is "100% x+5" where x is the x offset in the sprite
      # * sprite_offset("common", "icon", "top", "right") => offset is "top right"
      def sprite_offset(group, image, x=nil, y=nil)
        xoff = compute_offset(group, image, :x, x)
        yoff = compute_offset(group, image, :y, y)
        ::Sass::Script::String.new "#{xoff} #{yoff}"
      end

    protected
      def compute_offset(group, image, axis, offset)
        if offset
          val = offset.value
          if val.is_a? Fixnum
            (sprite_attr(axis, group, image).to_i + val).to_s + 'px'
          else
            val
          end
        else
          sprite_attr(axis, group, image)
        end
      end

      def sprite_attr(attr, group, image)
        sprite = sprite_data(group, image)
        if sprite
          "#{sprite[attr]}px"
        else
          ""
        end
      end

      def sprite_builder
        @__sprite_builder ||= Builder.from_config
      end

      def sprite_data(group, image)
        unless @__sprite_data
          sprite_data_path = sprite_builder.style_output_path

          # read sprite data from yml
          @__sprite_data = File.open(sprite_data_path) { |yf| YAML::load( yf ) }
        end

        group_data = @__sprite_data[group.value]
        if group_data
          return group_data[image.value]
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
