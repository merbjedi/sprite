require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Sprite::Builder do

  context "configuration parsing" do
    before(:all) do
      @sprite = Sprite::Builder.from_config("resources/configs/config-test.yml")
    end

    it "loads the image keys from file" do
      @sprite.images.size.should == 2
    end

    it "expands any globs within the source paths" do
      @sprite.images.first["sources"].size.should == 30
    end

    it "allows override of css_image_path value" do
      @sprite.config['css_image_path'].should == '../images/sprites'
    end
  end

  context "default settings" do
    before(:all) do
      @sprite = Sprite::Builder.new
    end

    it "'style:' setting defaults to 'css'" do
      @sprite.config['style'].should == "css"
    end

    it "'style_output_path:' setting defaults to 'stylesheets/sprites'" do
      @sprite.config['style_output_path'].should == "stylesheets/sprites"
    end

    it "'image_output_path:' setting defaults to 'images/sprites/'" do
      @sprite.config['image_output_path'].should == "images/sprites/"
    end

    it "'css_image_path:' setting defaults to '/images/sprites/'" do
      @sprite.config['css_image_path'].should == "/images/sprites/"
    end

    it "'image_source_path:' setting defaults to 'images/'" do
      @sprite.config['image_source_path'].should == "images/"
    end

    it "'public_path:' setting defaults to 'public/'" do
      @sprite.config['public_path'].should == "public/"
    end

    it "'default_format:' setting defaults to 'png'" do
      @sprite.config['default_format'].should == "png"
    end

    it "'sprites_class:' setting defaults to 'sprites'" do
      @sprite.config['sprites_class'].should == "sprites"
    end

    it "'class_separator:' setting defaults to '-'" do
      @sprite.config['class_separator'].should == "-"
    end
  end
end
