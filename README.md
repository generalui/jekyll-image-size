# Jekyll-Image-Size

This Jekyll pluging provides a tag that reads the image-size of a static asset and outputs it in your template. I'm building it specifically to generate the og-image-width and og-image-height opengraph tags, but it has so many other uses.

## Installation

Add this line to your Gemfile:

```ruby
group :jekyll_plugins do
  gem "jekyll-image-size"
end
```

And then execute:

    $ bundle

Alternatively install the gem yourself as:

    $ gem install jekyll-image-size

and put this in your ``_config.yml``

```yaml
plugins: [jekyll-image-size]
 # This will require each of these gems automatically.
```

## File Types Supported

Jekyll-image-size uses the fastimage gem. It supports every type fastimage support. As of right now, that means:

```
gif, jpeg, png, tiff, bmp, ico, cur, psd, svg, webp
```


## Usage

The `imagesize` takes one parameter. That parameter has the form:

```
imageSource[:mode[/divide-by-number]][ rest...]

imageSource is a string and can be one of:
  url
  file (rooted in the project root)
  Liquid/Jekyll context-variable name

modes:
  size:       WxH
  width:      W
  height:     H
  css:        width: Wpx; height: Hpx;
  props:      width='W' height='H'
  opengraph:  <meta property='og:image:width' content='W'/><meta property='og:image:height' content='H'/>

divide-by-numbers:
  integer:    2
  float:      2.5 or 0.5 or .5

rest:
  - must start with a space
  - only used for the "img" tag mode
  - appended to the end of the img-tag just before the ">".
```

```
# modes
{% imagesize imageSource %}           # 652x435
{% imagesize imageSource:size %}      # 652x435
{% imagesize imageSource:size/2 %}    # 326x218
{% imagesize imageSource:width %}     # 652
{% imagesize imageSource:height %}    # 435
{% imagesize imageSource:css %}       # width: 652px; height: 435px;
{% imagesize imageSource:props %}     # width='652' height='435'
{% imagesize imageSource:opengraph %} # <meta property='og:image:width' content='350'/><meta property='og:image:height' content='32'/>
{% imagesize imageSource:img %}       # <img src='spec/data/test.png' width='350' height='32'>

# imageSource examples
{% imagesize /assets/logo.jpg %}
{% assign image = site.image %}
{% imagesize image %}

# combined examples
{% imagesize /assets/logo.jpg:opengraph %}
{% imagesize /assets/logo.jpg:css/2 %}
{% imagesize image:width/2.5 %}
{% imagesize imageSource:img alt='my alt string' %}
# <img src='spec/data/test.png' width='350' height='32' alt='my alt string'>

```

## License

jekyll-image-size is [MIT licensed](./LICENSE).

## Produced By

jekyll-image-size was produced at [GenUI.co](https://www.genui.co).
