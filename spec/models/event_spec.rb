require 'spec_helper'

describe Event do
  
  subject { Factory.build(:event) }
  
  it { should be_valid }
  
  describe "name" do
    
    context "when blank" do
      
      before { subject.name = '' }
      
      it { should_not be_valid }
    
      it "adds an error" do
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
    
      it "adds an error" do
        subject.save
      
        subject.errors[:name].should include("is already taken")
      end
      
  end
  
  describe "start" do
    
    context "when blank" do
      
      before { subject.start = nil }
      
      it { should_not be_valid }
    
      it "adds an error" do
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
      
      it "adds an error" do
        subject.save
        subject.errors[:location].should include("can't be blank")
      end
      
    end

  end
  
  describe "description" do
    
    context "when blank" do
    
      before { subject.description = "" }

      it { should_not be_valid }
    
      it "adds an error" do
        subject.save
        subject.errors[:description].should include("can't be blank")
      end
      
    end
      
  end
  
  describe "finish time" do
    
    context "when after start time" do
      
      before { subject.finish = subject.start - 1.year }
      
      it { should_not be_valid }
    
      it "adds an error" do
        subject.save
        subject.errors[:finish].should include("should be after start time")
      end
      
    end
    
    context "when blank" do
      
      before { subject.finish = nil }
    
      it "adds error if til_whenever not checked" do
        subject.til_whenever = false
        subject.should_not be_valid
      end
    
      it "doesn't add error if til_whenever checked" do
        subject.til_whenever = true
        subject.should be_valid
      end
      
      it "makes the duration 0" do
        subject.duration.should == 0
      end
      
    end

  end
  
  describe "scope" do
  
    let(:event) { Factory(:event) }
  
    describe "#happening_now" do
    
      subject { Event.happening_now }
    
      it "includes events happening now" do
        event.start = 1.year.ago
        event.finish = 1.year.from_now
        event.save
      
        subject.should include(event)
      end
    
      it "doesn't include future events" do
        event.start = 1.year.from_now
        event.finish = 2.years.from_now
        event.save
      
        subject.should_not include(event)
      end
    
      it "doesn't include past events" do
        event.start = 2.years.ago
        event.finish = 1.year.ago
        event.save
      
        subject.should_not include(event)
      end
    
    end
    
    describe "#upcoming" do
      
      subject { Event.upcoming }
      
      it "doesn't include past events" do
        event.start = 1.year.ago
        event.save
        
        subject.should_not include(event)
      end
      
      it "includes future events" do
        event.start = 1.year.from_now
        event.finish = 2.years.from_now
        event.save
        
        subject.should include(event)
      end
      
      it "sorts events ascending" do
        sooner_event = Factory(:event, :start => 1.year.from_now, :finish => 2.years.from_now)
        later_event = Factory(:event, :start => 9.years.from_now, :finish => 10.years.from_now)
      
        events = subject.to_a
        
        events.index(sooner_event).should be < events.index(later_event)
      end
      
    end
  
    describe "#featured" do
    
      subject { Event.featured }
    
      it "contains featured events" do
        event.update_attributes!(:featured => true)
    
        subject.should include(event)
      end
  
      it "doesn't contain unfeatured events" do
        event.update_attributes!(:featured => false)
    
        subject.should_not include(event)
      end
    
      it "sorts by page_rank descending" do
        low_rank = Factory(:event, :featured => true, :page_rank => 1)
        high_rank = Factory(:event, :featured => true, :page_rank => 99)
      
        subject.to_a.index(low_rank).should be > subject.to_a.index(high_rank)
      end
    
    end
    
  end
  
  describe "duration" do
    
    it "calculates the minutes from start to finish" do
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
    
    it "are assignable" do
      subject.categories.should include(category)
    end
    
    it "have a reference to the event" do
      category.events.should include(subject)
    end
    
  end
  
  describe "page_rank" do
    
    it "defaults to zero" do
      subject.page_rank.should == 0
    end
    
  end
  
  describe "creator" do
    
    let(:user) { Factory(:user) }
    
    before do
      subject.creator = user
      subject.save
    end
    
    it "is assignable" do
      subject.creator.should == user
    end
    
    it "has a reference to the event" do
      user.events.should include(subject)
    end
    
  end
  
  describe "free?" do
    
    context "when free checked" do
      
      before { subject.free = true }
      
      it "blanks out cost" do
        subject.save
        subject.cost.should be_nil
      end
      
      it "is true" do
        subject.free?.should == true
      end
      
    end
    
    context "when free not checked" do
      
      it "is false" do        
        subject.free?.should == false
      end
      
    end
    
  end
  
  describe "til_whenever?" do
    
    context "when til_whenever checked" do 
    
      before { subject.til_whenever = true }
    
      it "blanks out finish" do
        subject.save
        subject.finish.should be_nil
      end
    
      it "is true" do
        subject.til_whenever?.should == true
      end
      
    end
    
    context "when til_whenever not checked" do
    
      it "is false" do
        subject.til_whenever?.should == false
      end
      
    end
    
  end
  
  describe "images" do
    
    it "don't accept invalid attachment types" do
      subject.update_attributes(:image => Rack::Test::UploadedFile.new(File.dirname(__FILE__) + '/../fixtures/not_an_image.txt', 'text/plain'))
      
      subject.errors[:image].should include("uploads must be a .jpg, .gif, or .png file.")
    end
    
    it "throw an error when they can't be processed" do
      pending "carrierwave github issue #191"
      # TODO: check to see if github issue has been resolved
    end
    
  end
  
  pending "habtm on locations"
  
end
