require 'spec_helper'

describe EventsController do
  
  include Devise::TestHelpers # TODO remove when rspec wises up
  
  before(:each) do
    @event = Factory.build(:event)
  end

  it "should assign @event on new" do
    Event.should_receive(:new).and_return(@event)
    get :new
    assigns[:event].should == @event
  end
  
  it "should assign requested @event on show" do
    Event.should_receive(:find).
         with("my-event").
         and_return(@event)
    get :show, :event => { "id" => "my-event" }
    assigns[:event].should == @event
  end
  
  it "should create a new event" do
    Event.should_receive(:new).
          with("name" => "event").
          and_return(@event)
    post :create, :event => { "name" => "event" }
  end
  
  it "should locate the related location on create" do
    Location.stub!(:find)
    Location.should_receive(:find).
             with(:name => "someplace")
    post :create, :event => { "location_name" => "someplace" }
  end
  
  it "should assign related location on create"
  
  it "should assign @events on index" do
    Event.should_receive(:find).and_return([@event])
    get :index
    assigns[:events].should == [@event]
  end
  
  context "on successful save" do
    
    before(:each) do
      Event.should_receive(:new).
            and_return(@event)
      @event.should_receive(:save).and_return(true)
      post :create, :event => {}
    end
    
    specify { flash[:notice].should == "The event was saved successfully" }
    
    it { should redirect_to(events_path) }
    
  end

end
