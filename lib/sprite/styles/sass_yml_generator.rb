require 'yaml'
module Sprite
  module Styles
    # renders a yml file that is later parsed by a sass extension when generating the mixins
    class SassYmlGenerator
      def initialize(builder)
        @builder = builder
      end

      def write(path, sprite_files)
        # build the yml file
        write_config(path, sprite_files)

        # Where to put the sass mixin file
        sass_path = path.gsub(".yml", ".sass")

        # write the sass mixins to disk
        File.open(File.join(Sprite.root, sass_path), 'w') do |f|
          f.puts "!sprite_data = '#{path}'"
          f.puts ""
          f.puts "= sprite(!group_name, !image_name)"
          f.puts "  background= sprite_background(!group_name, !image_name)"
          f.puts "  width= sprite_width(!group_name, !image_name)"
          f.puts "  height= sprite_height(!group_name, !image_name)"
          f.puts ""
        end
      end

      # write the sprite configuration file (used by the yml extension)
      def write_config(path, sprite_files)
        # build a grouped hash with all the sprites in it
        result = {}
        sprite_files.each do |sprite_file, sprites|
          sprites.each do |sprite|
            if sprite[:group]
              result[sprite[:group]] ||= {}
              result[sprite[:group]][sprite[:name]] = sprite
            end
          end
        end

        # write the config yml to disk
        File.open(File.join(Sprite.root, path), 'w') do |f|
          YAML.dump(result, f)
        end
      end

      def extension
        "yml"
      end
    end
  end
end
