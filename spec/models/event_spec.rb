require 'spec_helper'

describe Event do
  
  subject { Factory(:event) }
  let(:event) { Factory(:event) }
  
  it { should be_valid }

  describe "validations" do
    
    it 'should require a name' do
      event.name = ''
      event.should_not be_valid
    end

    it 'should require a unique name' do
      duplicate_name_event = Factory(:event)
      
      event.name = duplicate_name_event.name
      event.should_not be_valid
      
      event.name = 'Other random name'
      event.should be_valid
    end

    it 'should require a start' do
      event.start = nil
      event.should_not be_valid
      
      event.save
      event.errors[:start].should include("can't be blank")
    end

    it 'should require a location' do
      event = Factory.build(:event, :location => nil)
      event.should_not be_valid
      
      event.save
      event.errors[:location].should include("can't be blank")
    end

    it 'should require a description' do
      event.description = ""
      event.should_not be_valid
      
      event.save
      event.errors[:description].should include("can't be blank")
    end

    it 'should require a finish time after the start time' do
      event.finish = event.start - 1.year
      event.should_not be_valid
      
      event.save
      event.errors[:finish].should include("should be after start time")
      
      event.finish = event.start + 1.hour
      event.should be_valid
    end
  end
  
  describe "happening_now scope" do
    
    it "should include events happening now" do
      event.start = 1.year.ago
      event.finish = 1.year.from_now
      event.save
      
      Event.happening_now.should include(event)
    end
    
    it "should not include future events" do
      event.start = 1.year.from_now
      event.finish = 2.years.from_now
      event.save
      
      Event.happening_now.should_not include(event)
    end
    
    it "should not include past events" do
      event.start = 2.years.ago
      event.finish = 1.year.ago
      event.save
      
      Event.happening_now.should_not include(event)
    end
    
  end
  
  describe "featured" do
    
    describe "scope" do
    
      it "should contain featured events" do
        event.featured = true
        event.save
      
        Event.featured.should include(event)
      end
    
      it "should not contain unfeatured events" do
        event.featured = false
        event.save
      
        Event.featured.should_not include(event)
      end
      
    end
    
  end
  
  describe "duration" do
    
    it "should be zero if finish is nil" do
      event.finish = nil
      
      event.duration.should == 0
    end
    
    it "should calculate correctly" do
      event.start = Time.parse("4:30")
      event.finish = Time.parse("4:31")
      
      event.duration.should == 60
    end
    
  end
  
  it "should generate an SEO-friendly url parameter" do
    event.name = "2010: The Big, Big Event"
    event.id = 42
    
    event.to_param.should == "42-2010-the-big-big-event"
  end
  
  describe "categories" do
    
    it "should be assignable" do
      category1 = Factory(:category, :name => 'party')
      category2 = Factory(:category, :name => 'lecture')
      
      event.categories << category1
      event.categories << category2
      
      event.categories.should include(category1)
      event.categories.should include(category2)
    end
    
  end
  
  describe "free?" do
    
    it "should be true when the cost is zero" do
      event.cost = 0
      event.free?.should == true
    end
    
    it "should not be free when the cost is nonzero" do
      event.cost = 99
      event.free?.should == false
    end
    
  end
  
  describe "til_whenever?" do
    
    it "should be true if there's no end time" do
      event.finish = nil
      event.til_whenever?.should == true
    end
    
    it "should be false if there's an end time" do
      event.finish = 1.year.from_now
      event.til_whenever?.should == false
    end
    
  end
  
  describe "images" do
    
    # it "should not accept invalid attachment types" do
    #   event.update_attributes!(:image => Rack::Test::UploadedFile.new(File.dirname(__FILE__) + '/../fixtures/not_an_image.txt', 'text/plain'))
    #   
    #   event.errors[:image].should == "Image uploads must be a .jpg, .gif, or .png file."
    # end
    
    it "should have a default image" do
      event.image.url.should include("default.png")
    end
    
  end
  
  pending "habtm on users"
  pending "habtm on locations"
  
end
