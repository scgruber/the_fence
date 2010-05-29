require 'spec_helper'

describe "events/show.html.haml" do

  pending "rspec not sucking"
  
  # before(:each) do
  #   @event = mock_model(Event, :null_object => true)
  #   # @event.stub_chain(:poster, :url).and_return "#"
  #   assign(:event, @event)
  # end
  # 
  # it "should put events in an hEvent tag" do
  #   render
  #   response.should have_selector(".vevent")
  # end
  # 
  # it "should list event name" do
  #   @event.stub!(:name).and_return "My Event"
  #   
  #   render "events/show.html.erb"
  #   response.should have_selector(".vevent .summary", :content => "My Event")
  # end
  # 
  # it "should list an event location" do
  #   @event.stub!(:location).and_return Location.new(:name => 'My Location')
  #   
  #   render "events/show.html.erb"
  #   response.should have_selector(".vevent .location", :content => "My Location")
  # end
  # 
  # it "should list a start time" do
  #   @event.stub!(:start).and_return Time.parse("10/5/09 00:00:00 UTC")
  #   
  #   render "events/show.html.erb"
  #   response.should have_selector(".vevent .dtstart", :title => "2009-10-05T00:00:00Z")
  #   # TODO: Decide on sane date format. Add content matcher for selector.
  # end
  # 
  # it "should list a finish time" do
  #   @event.stub!(:finish).and_return Time.parse("10/5/09 00:00:00 UTC")
  #   
  #   render "events/show.html.erb"
  #   response.should have_selector(".vevent .dtend", :title => "2009-10-05T00:00:00Z")
  # end
  # 
  # it "should support indeterminate finish times" do
  #   @event.stub!(:finish).and_return nil
  #   
  #   render "events/show.html.erb"
  #   response.should_not have_selector(".vevent .dtend")
  #   response.should contain(/Whenever/i)
  # end
  # 
  # it "should list a description" do
  #   @event.stub!(:description).and_return "Description"
  #   
  #   render "events/show.html.erb"
  #   response.should have_selector(".vevent .description", :content => "Description")
  # end
  # 
  # it "should list categories" do
  #   @category = mock_model(Category)
  #   @category.should_receive(:name).and_return "My Category"
  #   
  #   @event.stub!(:categories).and_return [@category]
  #   
  #   render "events/show.html.erb"
  #   response.should have_selector(".vevent .category", :content => "My Category")
  # end
  # 
  # it "should display a poster" do
  #  @event.stub_chain(:poster, :url).and_return "poster/url"
  #  
  #  render "events/show.html.erb"
  #  response.should have_selector(".vevent .attach", :href => "poster/url")
  # end
  # 
  # it "should display a cost if one exists" do
  #   @event.stub!(:cost).and_return 5
  #   
  #   render "events/show.html.erb"
  #   response.should contain("$5")
  # end
  # 
  # it "should say free if the event is free" do
  #   @event.stub!(:cost).and_return 0
  #   
  #   render "events/show.html.erb"
  #   response.should contain(/Free/i)
  # end
  # 
  # describe 'links' do
  #   
  #   it "should include events index" do
  #     render "events/show.html.erb"
  #     
  #     response.should have_selector("a", :href => events_path)
  #   end
  #   
  #   it "should include iCal export" do
  #     render "events/show.html.erb"
  #     
  #     response.should have_selector("a", :href => event_path(@event, :format=> :ics))
  #   end
  #   
  #   context "when user has edit privileges" do
  #     
  #     it "should include edit" do
  #       render "events/show.html.erb"
  # 
  #       response.should have_selector("a", :href => edit_event_path(@event))
  #     end
  #     
  #   end
  #   
  #   context "when user doesn't have edit privileges" do
  #     
  #     before(:each) do
  #       template.should_receive(:can?).with(:edit, @event).and_return(false)
  #     end
  #     
  #     it "shouldn't include edit" do
  #       render "events/show.html.erb"
  # 
  #       response.should_not have_selector("a", :href => edit_event_path(@event))
  #     end
  #     
  #   end
  #   
  # end
  # 
  # # Now listed on subpage
  # # it "should list attendees" do
  # #   @user = mock_model(User)
  # #   @user.should_receive(:name).and_return "Can Duruk"
  # #   
  # #   @event.stub!(:users).and_return [@user]
  # #   
  # #   render "events/show.html.erb"
  # #   response.should have_selector(".vevent .attendee", :content => "Can Duruk")
  # # end
  
end
