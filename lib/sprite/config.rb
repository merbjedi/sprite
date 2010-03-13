module Sprite
  class Config
    DEFAULT_CONFIG_PATH = 'config/sprite.yml'

    def self.read_config(path = nil)
      config_path = File.join(Sprite.root, path || DEFAULT_CONFIG_PATH)
      
      # read configuration
      if File.exists?(config_path) 
        begin
          File.open(config_path) {|f| YAML::load(f)} || {}
        rescue => e
          puts "Error reading sprite config: #{config_path}"
          puts e.to_s
          {}
        end
      else
        {}
      end
    end
    
    # chop off the trailing slash on a directory path (if it exists)
    def self.chop_trailing_slash(path)
      path = path[0...-1] if path[-1] == File::SEPARATOR
      path
    end
    
    # check if the path is set
    def self.path_present?(path)
      path.to_s.strip != ""
    end
    
    def initialize(settings_hash)
      @settings = settings_hash
    end
    
    # get the disk path for a location within the public folder (if set)
    def public_path(location, relative = false)
      path_parts = []
      path_parts << Sprite.root unless relative
      path_parts << Config.chop_trailing_slash(@settings['public_path']) if Config.path_present?(@settings['public_path'])
      path_parts << location
      
      File.join(*path_parts)
    end    
    
  end
end  
