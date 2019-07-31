# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-image-size/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-image-size"
  spec.version       = Jekyll::ImageSize::VERSION
  spec.authors       = ["Shane Brinkman-Davis Delamore"]
  spec.email         = ["shane@genui.com"]

  spec.summary       = "jekyll tag plugin to insert the image-width and image-height of any static asset"
  spec.description   = "jekyll tag plugin to insert the image-width and image-height of any static asset"
  spec.homepage      = "https://github.com/shanebdavis/jekyll-image-size"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'jekyll',  '>= 3.7'
  spec.add_dependency 'fastimage', '>= 1.8'
  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
