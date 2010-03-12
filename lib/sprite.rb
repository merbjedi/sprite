module Sprite  
  
  # provides the root directory to use when reading and writing files
  def self.root
    @root ||= nil

    # set the root to the framework setting (if not already set)
    @root ||= begin
      if defined?(Rails)
        Rails.root
      elsif defined?(Merb)
        Merb.root
      else
        "."
      end
    end
    @root
  end  
end

require 'sprite/builder'
require 'sprite/config'
require 'sprite/image_combiner'
require 'sprite/image_config'
require 'sprite/image_reader'
require 'sprite/image_resizer'
require 'sprite/image_writer'
require 'sprite/styles'
