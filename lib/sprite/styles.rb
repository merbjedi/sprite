require 'sprite/styles/sass_generator'
require 'sprite/styles/css_generator'
require 'sprite/styles/sass_yml_generator'
require 'sprite/styles/sass_mixin_generator'
require 'sprite/styles/templated_css_generator'

module Sprite::Styles
  GENERATORS = {
    "css" => "CssGenerator",
    "templated_css" => "TemplatedCssGenerator",
    "sass" => "SassGenerator",
    "sass_mixin" => "SassMixinGenerator",
    "sass_yml" => "SassYmlGenerator"
  }

  def self.get(config)
    const_get(GENERATORS[config])
  rescue
    CssGenerator
  end

end