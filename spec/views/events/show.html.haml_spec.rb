require 'spec_helper'

describe "events/show.html.haml" do
  
  helper(EventsHelper)
  
  let(:event) { mock_model(Event).as_null_object }
  
  before(:each) do
    assign(:event, event)
    view.stub!(:can?).with(:edit, event).and_return(false)
  end
  
  it "should put events in an hEvent tag" do
    render
    rendered.should have_selector(".vevent")
  end
  
  it "should list event name in summary tag" do
    event.stub!(:name).and_return "My Event"
    
    render
    rendered.should have_selector(".vevent .summary", :content => "My Event")
  end
  
  it "should list an event location in location tag" do
    event.stub!(:location).and_return "My Location"
    
    render
    rendered.should have_selector(".vevent .location", :content => "My Location")
  end
  
  it "should list a start time in dtstart tag" do
    event.stub!(:start).and_return Time.parse("10/5/09 00:00:00 UTC")
    
    render
    rendered.should have_selector(".vevent .dtstart", :title => "2009-10-05T00:00:00Z")
    # TODO: Decide on sane date format. Add content matcher for selector.
  end
  
  it "should list a finish time" do
    event.stub!(:finish).and_return Time.parse("10/5/09 00:00:00 UTC")
    
    render
    rendered.should have_selector(".vevent .dtend", :title => "2009-10-05T00:00:00Z")
  end
  
  it "should support indeterminate finish times" do
    event.stub!(:finish).and_return nil
    
    render
    rendered.should_not have_selector(".vevent .dtend")
    rendered.should contain(/Whenever/i)
  end
  
  it "should list a description" do
    event.stub!(:description).and_return "Description"
    
    render
    rendered.should have_selector(".vevent .description", :content => "Description")
  end
  
  it "should list noun categories" do
    category = mock_model(Category)
    category.should_receive(:name).and_return "My Category"
    
    event.stub_chain(:categories, :adjective => [])
    event.stub_chain(:categories, :noun => [category])
    
    render
    rendered.should have_selector(".vevent .category.noun", :content => "my category")
  end
  
  it "should list adjective categories" do
    category = mock_model(Category)
    category.should_receive(:name).and_return "My Category"
    
    event.stub_chain(:categories, :adjective => [category])
    event.stub_chain(:categories, :noun => [])
    
    render
    rendered.should have_selector(".vevent .category.adjective", :content => "my category")
  end
  
  it "should display a poster" do
    event.stub_chain(:image, :url => "poster/url")
    event.stub_chain(:image, :medium, :url => "poster/url")

    render
    rendered.should have_selector(".vevent .attach", :href => "poster/url")
  end
  
  it "should display a cost if one exists" do
    event.stub!(:free?).and_return false
    event.stub!(:cost).and_return "$5"
    
    render
    rendered.should contain("$5")
  end
  
  it "should say free if the event is free" do
    event.stub!(:free?).and_return true
    event.stub!(:cost).and_return 0
    
    render
    rendered.should contain(/Free/)
  end
  
   describe 'links' do
    
    it "should include iCal export" do
      pending("we add iCal export")
      render
      
      rendered.should have_selector("a", :href => event_path(event, :format=> :ics))
    end
    
    context "when user has edit privileges" do
      
      before(:each) do
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
