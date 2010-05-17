require 'spec_helper'

module EventSpecHelper
  
  def valid_event_attributes
    {
      :name => "Event",
      :location => mock_model(Location, :name => 'place', :destroyed? => false).as_null_object,
      :start => "9/9/09",
      :finish => "10/10/10",
      :image => Rack::Test::UploadedFile.new(Rails.root + 'spec/fixtures/poster.gif', "image/gif"),
      :description => "Description"
    }
  end
end

describe Event do
  
  include EventSpecHelper
  
  before(:each) do
    @event = Event.new
  end
  
  it "should be valid" do
    @event.attributes = valid_event_attributes
    @event.should be_valid
  end

  describe "validations" do
    it 'should require a name' do
      @event.attributes = valid_event_attributes.except(:name)
      @event.should_not be_valid
      @event.name = valid_event_attributes[:name]
      @event.should be_valid
    end

    it 'should require a unique name' do
      Event.create(valid_event_attributes)
      @event.attributes = valid_event_attributes
      @event.should_not be_valid
      @event.name = 'Other random name'
      @event.should be_valid
    end

    it 'should require a start' do
      @event.attributes = valid_event_attributes.except(:start)
      @event.save
      @event.errors[:start].should include("can't be blank")
      @event.start = valid_event_attributes[:start]
      @event.should be_valid
    end

    it 'should require a location' do
      @event.attributes = valid_event_attributes.except(:location)
      @event.save
      @event.errors[:location].should include("can't be blank")
      # TODO: Why doesn't this work?
      # @event.location = valid_event_attributes[:location]
      # @event.should be_valid
    end

    it 'should require a description' do
      @event.attributes = valid_event_attributes.except(:description)
      @event.save
      @event.errors[:description].should include("can't be blank")
      @event.description = valid_event_attributes[:description]
      @event.should be_valid
    end

    it 'should require a finish time after the start time' do
      @event.attributes = valid_event_attributes
      @event.finish = @event.start - 1.year
      @event.save
      @event.errors[:finish].should include("should be after start time")
      @event.finish = @event.start + 1.hour
      @event.should be_valid
    end
  end
  
  describe "happening_now scope" do
    
    it "should include events happening now" do
      @event.attributes = valid_event_attributes.merge(:start => 1.year.ago, :finish => 1.year.from_now)
      @event.save
      
      Event.happening_now.should include(@event)
    end
    
    it "should not include future events" do
      @event.attributes = valid_event_attributes.merge(:start => 1.year.from_now, :finish => 2.years.from_now)
      @event.save
      
      Event.happening_now.should_not include(@event)
    end
    
    it "should not include past events" do
      @event.attributes = valid_event_attributes.merge(:start => 2.years.ago, :finish => 1.year.ago)
      @event.save
      
      Event.happening_now.should_not include(@event)
    end
    
  end
  
  describe "featured" do
    
    describe "scope" do
    
      before(:each) do
        @event.attributes = valid_event_attributes
      end
    
      it "should contain featured events" do
        @event.featured = true
        @event.save
      
        Event.featured.should include(@event)
      end
    
      it "should not contain unfeatured events" do
        @event.featured = false
        @event.save
      
        Event.featured.should_not include(@event)
      end
      
    end
    
    describe "attribute" do

      # TODO: Make sure this isn't necessary
      # it "should not be accessible by mass assignment" do
      #   @event.attributes = valid_event_attributes.merge(:featured => true)
      #   @event.send(:featured).should_not == true
      # end
      
    end
    
  end
  
  describe "duration" do
    
    it "should be zero if finish is nil" do
      @event.finish = nil
      
      @event.duration.should == 0
    end
    
    it "should calculate correctly" do
      @event.start = Time.parse("4:30")
      @event.finish = Time.parse("4:31")
      
      @event.duration.should == 60
    end
    
  end
  
  it "should generate an SEO-friendly url parameter" do
    @event.name = "2010: The Big, Big Event"
    @event.id = 42
    
    @event.to_param.should == "42-2010-the-big-big-event"
  end
  
  describe "categories" do
    
    it "should be assignable" do
      category1 = mock_model(Category, :name => 'party').as_null_object
      category2 = mock_model(Category, :name => 'lecture').as_null_object
      
      @event.categories << category1
      @event.categories << category2
      
      @event.categories.should include(category1)
      @event.categories.should include(category2)
    end
    
  end
  
  describe "free?" do
    
    it "should be true when the cost is zero" do
      @event.cost = 0
      @event.free?.should == true
    end
    
    it "should not be free when the cost is nonzero" do
      @event.cost = 99
      @event.free?.should == false
    end
    
  end
  
  describe "til_whenever?" do
    
    it "should be true if there's no end time" do
      @event.finish = nil
      @event.til_whenever?.should == true
    end
    
    it "should be false if there's an end time" do
      @event.finish = 1.year.from_now
      @event.til_whenever?.should == false
    end
    
  end
  
  describe "images" do
    
    # it "should not accept invalid attachment types" do
    #   @event.attributes = valid_event_attributes.merge!(:image => Rack::Test::UploadedFile.new(Rails.root + 'spec/fixtures/not_an_image.txt', "text/plain"))
    #   @event.stub!(:save_attached_files).and_return true
    #   @event.save
    #   
    #   @event.errors[:image].should == "Image uploads must be a .jpg, .gif, or .png file."
    # end
    
    it "should have a default image" do
      @event.image.url.should include("default.png")
    end
    
  end
  
  it "should habtm Users"
  
end
