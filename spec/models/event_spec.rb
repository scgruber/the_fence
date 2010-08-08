require 'spec_helper'

describe Event do
  
  subject { Factory.build(:event) }
  
  it { should be_valid }
  
  describe "name" do
    
    context "when blank" do
      
      before { subject.name = '' }
      
      it { should_not be_valid }
    
      it "should add an error" do
        subject.save
        subject.errors[:name].should include("can't be blank")
      end
    
    end
    
    context "when already taken"
    
      before do
        duplicate_name_event = Factory(:event)
        subject.name = duplicate_name_event.name
      end
    
      it { should_not be_valid }
    
      it "should add an error" do
        subject.save
      
        subject.errors[:name].should include("is already taken")
      end
      
  end
  
  describe "start" do
    
    context "when blank" do
      
      before { subject.start = nil }
      
      it { should_not be_valid }
    
      it "should add an error" do
        subject.start = nil
        subject.save
        subject.errors[:start].should include("can't be blank")
      end
      
    end
    
  end
  
  describe "location" do
    
    context "when blank" do
      
      before { subject.location = nil }
      
      it { should_not be_valid }
      
      it "should add an error" do
        subject.save
        subject.errors[:location].should include("can't be blank")
      end
      
    end

  end
  
  describe "description" do
    
    context "when blank" do
    
      before { subject.description = "" }

      it { should_not be_valid }
    
      it "should add an error" do
        subject.save
        subject.errors[:description].should include("can't be blank")
      end
      
    end
      
  end
  
  describe "finish time" do
    
    context "when after start time" do
      
      before { subject.finish = subject.start - 1.year }
      
      it { should_not be_valid }
    
      it "should add an error" do
        subject.save
        subject.errors[:finish].should include("should be after start time")
      end
      
    end
    
    context "when blank" do
      
      before { subject.finish = nil }
    
      it "should add error if til_whenever not checked" do
        subject.til_whenever = false
        subject.should_not be_valid
      end
    
      it "shouldn't add error if til_whenever checked" do
        subject.til_whenever = true
        subject.should be_valid
      end
      
      it "should make the duration 0" do
        subject.duration.should == 0
      end
      
    end

  end
  
  describe "scope" do
  
    let(:event) { Factory(:event) }
  
    describe "#happening_now" do
    
      subject { Event.happening_now }
    
      it "should include events happening now" do
        event.start = 1.year.ago
        event.finish = 1.year.from_now
        event.save
      
        subject.should include(event)
      end
    
      it "should not include future events" do
        event.start = 1.year.from_now
        event.finish = 2.years.from_now
        event.save
      
        subject.should_not include(event)
      end
    
      it "should not include past events" do
        event.start = 2.years.ago
        event.finish = 1.year.ago
        event.save
      
        subject.should_not include(event)
      end
    
    end
    
    describe "#upcoming" do
      
      subject { Event.upcoming }
      
      it "should not include past events" do
        event.start = 1.year.ago
        event.save
        
        subject.should_not include(event)
      end
      
      it "should include future events" do
        event.start = 1.year.from_now
        event.finish = 2.years.from_now
        event.save
        
        subject.should include(event)
      end
      
      it "should sort events ascending" do
        sooner_event = Factory(:event, :start => 1.year.from_now, :finish => 2.years.from_now)
        later_event = Factory(:event, :start => 9.years.from_now, :finish => 10.years.from_now)
      
        events = subject.to_a
        
        events.index(sooner_event).should be < events.index(later_event)
      end
      
    end
  
    describe "#featured" do
    
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
    
  end
  
  describe "duration" do
    
    it "should calculate the minutes from start to finish" do
      subject.start = Time.parse("4:30")
      subject.finish = Time.parse("4:31")
      
      subject.duration.should == 60
    end
    
  end
  
  describe "categories" do
    
    let(:category) { Factory(:category) }
    
    before do
      subject.categories << category
      subject.save
    end
    
    it "should be assignable" do
      subject.categories.should include(category)
    end
    
    it "should have a reference to the event" do
      category.events.should include(subject)
    end
    
  end
  
  describe "page_rank" do
    
    it "should default to zero" do
      subject.page_rank.should == 0
    end
    
  end
  
  describe "creator" do
    
    let(:user) { Factory(:user) }
    
    before do
      subject.creator = user
      subject.save
    end
    
    it "should be assignable" do
      subject.creator.should == user
    end
    
    it "should have a reference to the event" do
      user.events.should include(subject)
    end
    
  end
  
  describe "free?" do
    
    it "should be true when free is checked" do
      pending "I add a free field to the form"
    end
    
  end
  
  describe "til_whenever?" do
    
    context "til_whenever checked" do 
    
      before { subject.til_whenever = true }
    
      it "should blank out finish" do
        subject.save
        subject.finish.should be_nil
      end
    
      it "should be true" do
        subject.til_whenever?.should == true
      end
      
    end
    
    context "til_whenever not checked" do
    
      it "should be false" do
        subject.til_whenever?.should == false
      end
      
    end
    
  end
  
  describe "images" do
    
    it "should not accept invalid attachment types" do
      subject.update_attributes(:image => Rack::Test::UploadedFile.new(File.dirname(__FILE__) + '/../fixtures/not_an_image.txt', 'text/plain'))
      
      subject.errors[:image].should include("uploads must be a .jpg, .gif, or .png file.")
    end
    
  end
  
  pending "habtm on locations"
  
end
