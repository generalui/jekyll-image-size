# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-image-size/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-image-size"
  spec.version       = Jekyll::ImageSize::VERSION
  spec.authors       = ["Shane Brinkman-Davis Delamore"]
  spec.email         = ["shane@genui.com"]

  spec.summary       = "Jekyll tag-plugin to read images and output image-sizes as: opengraph tags, img-tags, css and more - with retina support"
  spec.description   = <<ENDDESC
Jekyll tag-plugin to read image sizes from static assets and output in many formats.

Generate your opengraph link-tags, img-tags, css, html props, or just output the width and height of an image. All output image-sizes
can be scaled for retina support (/2 for @2x retina, /3 for @3x, etc...).
ENDDESC
  spec.homepage      = "https://github.com/generalui/jekyll-image-size"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'jekyll',  '>= 3.7'
  spec.add_dependency 'fastimage', '>= 1.8'
  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
