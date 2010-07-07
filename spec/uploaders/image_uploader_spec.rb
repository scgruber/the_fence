require 'spec_helper'

require 'carrierwave/test/matchers'

describe ImageUploader do
  
  before do
    ImageUploader.enable_processing = true
    @uploader = ImageUploader.new
    image_file = File.dirname(__FILE__) + '/../fixtures/poster.gif'
    @uploader.store!(File.open(image_file))
  end
  
  context "thumb version" do
    
    it "should be 50 by 50" do
      @uploader.thumb.should have_dimensions(50,50)
    end
    
  end
  
end