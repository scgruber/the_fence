require 'spec_helper'

require 'carrierwave/test/matchers'

describe ImageUploader do
  
  before do
    ImageUploader.enable_processing = true
    @uploader = ImageUploader.new
    image_file = File.dirname(__FILE__) + '/../fixtures/poster.gif'
    @uploader.store!(File.open(image_file))
  end
  
  after do
    ImageUploader.enable_processing = false
  end
  
  context "thumb version" do
    
    it "is 50x50" do
      pending("carrierwave matchers work")
      @uploader.thumb.should have_dimensions(50,50)
    end
    
    it "upscales" do
      pending("carrierwave matchers work")
    end
    
  end
  
end