require 'jekyll-image-size'

RSpec.describe ImageSizeTag, ".getImageSize" do

  context "image-types" do
    it "works with png" do
      expect(ImageSizeTag.getImageSize("spec/data/test.png")).to eq("350x32")
    end

    it "works with jpg" do
      expect(ImageSizeTag.getImageSize("spec/data/test.jpg")).to eq("218x234")
    end
  end

  context "modes:" do
    it "returns WxH when no mode specified" do
      expect(ImageSizeTag.getImageSize("spec/data/test.png")).to eq("350x32")
    end

    it "raises error for :invalid" do
      expect {ImageSizeTag.getImageSize("/spec/data/test.png:invalid")}.to raise_error ImageSizeError
    end

    it "raises error for /:$/" do
      expect {ImageSizeTag.getImageSize("/spec/data/test.png:")}.to raise_error ImageSizeError
    end

    it "returns WxH for :size" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:size")).to eq("350x32")
    end

    it "returns W with :width" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:width")).to eq("350")
    end

    it "returns H with :height" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:height")).to eq("32")
    end

    it "returns css-style props with :css" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:css")).to eq("width: 350px; height: 32px;")
    end

    it "returns img-props with :props" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:props")).to eq("width='350' height='32'")
    end

    it "returns WxH for :opengraph" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:opengraph")).to eq(
        "<meta property='og:image:width' content='350'/><meta property='og:image:height' content='32'/>"
      )
    end

    it "returns <img...> with :img" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:img alt='Hi team'")).to eq(
        "<img src='/spec/data/test.png' width='350' height='32' alt='Hi team'>"
      )
    end

  end

  context "source-locations:" do
    it "returns 0x0 for missing source and :size" do
      expect(ImageSizeTag.getImageSize("/spec/data/foo.png")).to eq("0x0")
    end

    it "returns '' for missing source and :css, :props and :opengraph" do
      expect(ImageSizeTag.getImageSize("/spec/data/foo.png:css")).to eq("")
      expect(ImageSizeTag.getImageSize("/spec/data/foo.png:props")).to eq("")
      expect(ImageSizeTag.getImageSize("/spec/data/foo.png:opengraph")).to eq("")
    end

    it "throw error with '!'" do
      expect {ImageSizeTag.getImageSize("/spec/data/foo.png!")}.to raise_error ImageSizeError
      expect {ImageSizeTag.getImageSize("/spec/data/foo.png:size!")}.to raise_error ImageSizeError
    end

    it "ignores leading /" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png")).to eq("350x32")
    end

    it "looks up in context" do
      expect(ImageSizeTag.getImageSize("myImage", "myImage" => "/spec/data/test.png")).to eq("350x32")
    end
  end

  context "math:" do

    it "returns W/2xH/2 with :size/2" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:size/2")).to eq("175x16")
    end

    it "returns width/2 with :width/2" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:width/2")).to eq("175")
    end

    it "returns W*2xH*2 with :size/.5" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:size/.5")).to eq("700x64")
    end

    it "returns W*2xH*2 with :size/0.5" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:size/.5")).to eq("700x64")
    end

    it "returns width/2 with :width/2.5" do
      expect(ImageSizeTag.getImageSize("/spec/data/test.png:width/2.5")).to eq("140")
    end

  end

end