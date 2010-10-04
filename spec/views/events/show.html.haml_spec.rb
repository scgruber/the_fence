require 'spec_helper'

describe "events/show.html.haml" do
  
  helper(EventsHelper)
  
  let(:event) { mock_model(Event).as_null_object }
  
  before(:each) do
    assign(:event, event)
    view.stub!(:can?).with(:edit, event).and_return(false)
  end
  
  describe ".vevent" do
    
    it "contains events" do
      render
      rendered.should have_selector(".vevent")
    end
    
  end
  
  describe ".summary" do
    
    it "contains name" do
      event.stub!(:name).and_return "My Event"

      render
      rendered.should have_selector(".vevent .summary", :content => "My Event")
    end
    
  end
  
  describe ".location" do
    
    it "contains location" do
      event.stub!(:location).and_return "My Location"

      render
      rendered.should have_selector(".vevent .location", :content => "My Location")
    end
    
  end
  
  describe ".dtstart" do
    
    it "contains start time" do
      event.stub!(:start).and_return Time.utc(2009, 10, 5)

      render
      rendered.should have_selector(".vevent .dtstart", :title => "2009-10-05T00:00:00Z")
      # TODO: Decide on sane date format. Add content matcher for selector.
    end
    
  end
  
  describe ".dtend" do
    
    context "when event has finish time" do
      
      it "contains finish time" do
        event.stub!(:finish).and_return Time.utc(2009, 10, 5)

        render
        rendered.should have_selector(".vevent .dtend", :title => "2009-10-05T00:00:00Z")
      end
      
    end
    
    context "when event has no finish time" do
      
      it "contains 'Whenever'" do
        event.stub!(:finish).and_return nil

        render
        rendered.should_not have_selector(".vevent .dtend")
        rendered.should contain(/Whenever/i)
      end
      
    end
    
  end
  
  describe ".description" do
    
    it "contains description" do
      event.stub!(:description).and_return "Description"

      render
      rendered.should have_selector(".vevent .description", :content => "Description")
    end
    
  end
  
  describe ".category" do
    
    let(:category) { mock_model(Category, :name => "My Category") }
    
    describe ".noun" do
      
      it "contains noun categories" do
        event.stub_chain(:categories, :adjective => [])
        event.stub_chain(:categories, :noun => [category])

        render
        rendered.should have_selector(".vevent .category.noun", :content => "my category")
      end
      
    end
    
    describe ".adjective" do
      
      it "contains adjective categories" do
        event.stub_chain(:categories, :adjective => [category])
        event.stub_chain(:categories, :noun => [])

        render
        rendered.should have_selector(".vevent .category.adjective", :content => "my category")
      end
      
    end
    
  end
  
  describe ".attach" do
    
    it "contains poster image" do
      event.stub_chain(:image, :url => "poster/url")
      event.stub_chain(:image, :medium, :url => "poster/url")

      render
      rendered.should have_selector(".vevent .attach", :href => "poster/url")
    end
    
  end
  
  context "when events is free" do
    
    it "says 'Free'" do
      event.stub!(:free?).and_return true
      event.stub!(:cost).and_return 0

      render
      rendered.should contain(/Free/)
    end
    
  end
  
  context "when event is not free" do
    
    it "displays a cost" do
      event.stub!(:free?).and_return false
      event.stub!(:cost).and_return "$5"

      render
      rendered.should contain("$5")
    end
    
  end
  
  describe "links" do
    
    it "include iCal export" do
      pending("we add iCal export")
      render
  
      rendered.should have_selector("a", :href => event_path(event, :format=> :ics))
    end
    
    context "when user has edit privileges" do
      
      before do
        view.should_receive(:can?).with(:edit, event).and_return(true)
      end
      
      it "should include edit" do
        render
  
        rendered.should have_selector("a", :href => edit_event_path(event))
      end
      
    end
    
    context "when user doesn't have edit privileges" do
      
      it "shouldn't include edit" do
        render
  
        rendered.should_not have_selector("a", :href => edit_event_path(event))
      end
      
    end
    
  end
  
end
