# Jekyll-Image-Size

Jekyll tag-plugin to read image sizes from a static asset and output them in one of many formats.

Uses:

* generate your opengraph og:image:height and og:image:width tags
* IMG tags for retina-resolution assets (@2x, @3x, etc...)

Example outputs:

```
652x435
652
435
width: 652px; height: 435px;
width='652' height='435'
<meta property='og:image:width' content='350'/><meta property='og:image:height' content='32'/>
<img src='/assets/logo.jpg' width='350' height='32'>
```

## Installation

Add this line to your Gemfile:

```ruby
gem "jekyll-image-size"
```

and put this in your ``_config.yml``

```yaml
plugins:
  - image-size
```

## File Types Supported

Jekyll-image-size uses the fastimage gem. It supports every type [fastimage](https://github.com/sdsykes/fastimage) support. As of right now, that means:

```
gif, jpeg, png, tiff, bmp, ico, cur, psd, svg, webp
```


## Usage

The `imagesize` takes one parameter. That parameter has the form:

```
imageSource[:format[/divide-by-number]][ rest...]
```

imageSource is a string and can be one of:

* url
* file (rooted in the project root)
* Liquid/Jekyll context-variable name

formats:

* size:       `WxH`
* width:      `W`
* height:     `H`
* css:        `width: Wpx; height: Hpx;`
* props:      `width='W' height='H'`
* opengraph:  `<meta property='og:image:width' content='W'/><meta property='og:image:height' content='H'/>`
* img:        `<img src='/assets/logo.jpg' width='350' height='32'>`

divide-by-numbers:

* integer:    2
* float:      2.5 or 0.5 or .5

rest:

* must start with a space
* only used for the "img" tag format
* appended to the end of the img-tag just before the ">".

## Examples

Format examples:

```html
{% imagesize imageSource %}           # 652x435
{% imagesize imageSource:size %}      # 652x435
{% imagesize imageSource:size/2 %}    # 326x218
{% imagesize imageSource:width %}     # 652
{% imagesize imageSource:height %}    # 435
{% imagesize imageSource:css %}       # width: 652px; height: 435px;
{% imagesize imageSource:props %}     # width='652' height='435'
{% imagesize imageSource:opengraph %} # <meta property='og:image:width' content='350'/><meta property='og:image:height' content='32'/>
{% imagesize imageSource:img %}       # <img src='/assets/logo.jpg' width='350' height='32'>
```

Image source examples:

```html
{% imagesize /assets/logo.jpg %}
{% assign image = site.image %}
{% imagesize image %}
```

Combined examples:

```html
{% imagesize /assets/logo.jpg:opengraph %}
{% imagesize /assets/logo.jpg:css/2 %}
{% imagesize image:width/2.5 %}
{% imagesize /assets/logo.jpg:img alt='my alt string' %}
  # <img src='/assets/logo.jpg' width='350' height='32' alt='my alt string'>
```

## License

jekyll-image-size is [MIT licensed](./LICENSE).

## Produced By

jekyll-image-size was produced at [GenUI.co](https://www.genui.co).
