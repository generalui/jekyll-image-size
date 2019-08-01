# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-image-size/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-image-size"
  spec.version       = Jekyll::ImageSize::VERSION
  spec.authors       = ["Shane Brinkman-Davis Delamore"]
  spec.email         = ["shane@genui.com"]

  spec.summary       = "Jekyll tag-plugin to read image sizes from static assets and output in many formats."
  spec.description   = <<ENDDESC
Jekyll tag-plugin to read image sizes from static assets and output in many formats.

Uses:

* generate your opengraph og:image:height and og:image:width tags
* IMG tags for retina-resolution assets (@2x, @3x, etc...)
* Generate CSS or HTML width/height props
* or just output `width`, `height` or `width + "x" + height`
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
