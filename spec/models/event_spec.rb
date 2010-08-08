require 'spec_helper'

describe Event do
  
  subject { Factory(:event) }
  let(:event) { Factory(:event) }
  
  it { should be_valid }
  
  describe "name" do
    it "should be invalid if blank" do
      event.name = ''
      event.should_not be_valid
    end
    
    it "should add error if blank" do
      event.name = ''
      event.save
      event.errors[:name].should include("can't be blank")
    end
    
    it "should be invalid if already taken" do
      duplicate_name_event = Factory(:event)
      
      event.name = duplicate_name_event.name
      event.should_not be_valid
      
      event.name = 'Other random name'
      event.should be_valid
    end
    
    it "should add error if already taken" do
      duplicate_name_event = Factory(:event)
      duplicate_name_event.save
      event.name = duplicate_name_event.name
      event.save
      event.errors[:name].should include("is already taken")
    end
  end
  
  describe "start" do
    it "should be invalid if blank" do
      event.start = nil
      event.should_not be_valid
    end
    
    it "should add error if blank" do
      event.start = nil
      event.save
      event.errors[:start].should include("can't be blank")
    end
  end
  
  describe "location" do
    it "should be invalid if blank" do
      event = Factory.build(:event, :location => nil)
      event.should_not be_valid
    end
    
    it "should add error if blank" do
      event = Factory.build(:event, :location => nil)
      event.save
      event.errors[:location].should include("can't be blank")
    end
  end
  
  describe "description" do
    it "should be invalid if blank" do
      event.description = ""
      event.should_not be_valid
    end
    
    it "should add error if blank" do
      event.description = "" 
      event.save
      event.errors[:description].should include("can't be blank")
    end
  end
  
  describe "finish time" do
    it "should be invalid if after start time" do
      event.finish = event.start - 1.year
      event.should_not be_valid
      
      event.finish = event.start + 1.hour
      event.should be_valid
    end
    
    it "should add error if after start time" do
      event.finish = event.start - 1.year
            
      event.save
      event.errors[:finish].should include("should be after start time")
    end
    
    it "should add error if blank and til_whenever not checked" do
      event.finish = nil
      event.til_whenever = false
      event.should_not be_valid
    end
    
    it "shouldn't add error if blank and til_whenever checked" do
      event.finish = nil
      event.til_whenever = true
      event.should be_valid
    end
    
    it "should blank out if til_whenever checked" do
      event.til_whenever = true
      event.save
      event.finish.should be_nil
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
  
  describe "featured scope" do
    
    subject { Event.featured }
    
    it "should contain featured events" do
      event.update_attributes!(:featured => true)
    
      subject.should include(event)
    end
  
    it "should not contain unfeatured events" do
      event.update_attributes!(:featured => false)
    
      subject.should_not include(event)
    end
    
    it "should be sorted by page_rank descending" do
      low_rank = Factory(:event, :featured => true, :page_rank => 1)
      high_rank = Factory(:event, :featured => true, :page_rank => 99)
      
      subject.to_a.index(low_rank).should be > subject.to_a.index(high_rank)
    end
    
  end
  
  describe "duration" do
    
    it "should be zero if finish is nil" do
      event.finish = nil
      
      event.duration.should == 0
    end
    
    it "should calculate the minutes from start to finish" do
      event.start = Time.parse("4:30")
      event.finish = Time.parse("4:31")
      
      event.duration.should == 60
    end
    
  end
  
  describe "categories" do
    
    it "should be assignable" do
      category1 = Factory(:category, :name => 'party')
      category2 = Factory(:category, :name => 'lecture')
      
      event.categories << category1
      event.categories << category2
      event.save
      
      event.categories.should include(category1)
      event.categories.should include(category2)
    end
    
    it "should have a reference to the event" do
      category = Factory(:category, :name => 'party')
      
      event.categories << category
      event.save
      
      category.events.should include(event)
    end
    
  end
  
  describe "page_rank" do
    
    it "should default to zero" do
      event.page_rank.should == 0
    end
    
  end
  
  describe "creator" do
    
    it "should be assignable" do
      user = Factory(:user)
      event.update_attributes!(:creator => user)
      event.creator.should == user
    end
    
    it "should have a reference to the event" do
      user = Factory(:user)
      event.update_attributes!(:creator => user)
      user.events.should include(event)
    end
    
  end
  
  describe "free?" do
    
    it "should be true when free is checked" do
      pending "I add a free field to the form"
    end
    
  end
  
  describe "til_whenever?" do
    
    it "should be true if til_whenever is checked" do
      event.til_whenever = true
      event.til_whenever?.should == true
    end
    
    it "should be false if til_whenever is not checkd" do
      event.til_whenever = false
      event.til_whenever?.should == false
    end
    
  end
  
  describe "images" do
    
    it "should not accept invalid attachment types" do
      event.update_attributes(:image => Rack::Test::UploadedFile.new(File.dirname(__FILE__) + '/../fixtures/not_an_image.txt', 'text/plain'))
      
      event.errors[:image].should include("uploads must be a .jpg, .gif, or .png file.")
    end
    
  end
  
  pending "habtm on locations"
  
end
