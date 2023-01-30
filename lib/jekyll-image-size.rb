require "jekyll"
require 'fastimage'
require 'cgi'
require "jekyll-image-size/version"

class ImageSizeError < StandardError; end

# SEE https://github.com/Shopify/liquid/wiki/Liquid-for-Programmers
class ImageSizeTag < Liquid::Tag

  def initialize(tagName, content, tokens)
    super
    @content = content.strip
    @tokens = tokens
  end

  def self.getImageSize(content, context = nil)
    if m = content.match(/^((?:[^?:!]|:[^a-z])+)(?::([a-z]+)(?:\/((?:\d+|(?=\.))(?:\.\d+)?))?)?(\!)?(?:\?(.+))?( .*)?$/i)
      source, mode, scale, required, params, rest = m.captures

      if params
        params = CGI::parse(params)
      end
    else
      raise ImageSizeError.new "invalid imagesize parameter: #{content}"
    end

    rawSource = source

    source = source.sub(/^\//, '')
    if context
        source = File.join(context.registers[:site].source, source)
    end

    size = FastImage.size(source)
    if context && !size
      if contextSource = rawSource = context[source]
        contextSource = contextSource.sub(/^\//, '')
        size = FastImage.size(contextSource)
      end
    end

    if size && size[0] > 0 && size[1] > 0
      width, height = size
    else
      raise ImageSizeError.new "image file not found: #{source}" if required
      width = height = 0
    end

    if params
      aspect_ratio = width.to_f / height.to_f
      if v = params["width"][0]
        width = v.to_i
        height = (width / aspect_ratio).round

      elsif v = params["height"][0]
        height = v.to_i
        width = (height * aspect_ratio).round

      end
    end

    if scale
      scale = scale.to_f
      width  = (width  / scale).round
      height = (height / scale).round
    end

    case if mode then mode.downcase else nil end
    when "opengraph"
      if size then "<meta property='og:image:width' content='#{width}'/><meta property='og:image:height' content='#{height}'/>"
      else "" end

    when "img"        then
      if size then "<img src='#{rawSource}' width='#{width}' height='#{height}'#{rest}>"
      else "" end

    when "width"      then width.to_s
    when "height"     then height.to_s
    when "css"        then if size then "width: #{width}px; height: #{height}px;" else "" end
    when "props"      then if size then "width='#{width}' height='#{height}'" else "" end
    when "json"       then "{width: #{width}, height: #{height}}"
    when "array"      then "[#{width}, #{height}]"
    when "list"       then "#{width}, #{height}"
    when "size", nil  then "#{width}x#{height}"
    else raise ImageSizeError.new "invalid imagesize mode: #{mode}"
    end
  end

  def render(context)
    ImageSizeTag.getImageSize @content, context
  end

  Liquid::Template.register_tag "imagesize", self
end