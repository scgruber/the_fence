require 'spec_helper'

describe EventsController do
  
  include Devise::TestHelpers # TODO remove when rspec wises up
  
  before(:each) do
    @event = Factory.build(:event)
  end

  describe "new" do

    it "create a new event" do
      Event.should_receive(:new).
            and_return(@event)
      get :new
    end
    
    it "should assign a new event to view" do
      Event.stub!(:new).
            and_return(@event)
      get :new
      assigns[:event].should == @event
    end
    
  end
  
  describe "show" do
    
    it "should find the requested event" do
      Event.should_receive(:find).
           with("my-event")
      get :show, :id => "my-event"
    end
    
    it "should assign the requested event to view" do
      Event.stub!(:find).
           with("my-event").
           and_return(@event)
      get :show, :id => "my-event"
      assigns[:event].should == @event
    end
    
  end
  
  describe "create" do
  
    it "should create a new event with parameters" do
      Event.should_receive(:new).
            with("name" => "event").
            and_return(@event)
      post :create, :event => { "name" => "event" }
    end
    
    it "should assign the created event to view" do
      Event.stub!(:new).
            and_return(@event)
      post :create, :event => {}
      assigns[:event].should == @event
    end
    
    it "should blank out finish if til_whenever checked" do
      Event.should_receive(:new).
            with(hash_not_including(:finish)).
            and_return(@event)
    
      post :create, :event => { :finish => "5:30", :til_whenever => "1" }
    end
    
    it "should locate the related location" do
      pending("habtm support in mongoid")
      Location.should_receive(:find_or_create_by).
               with(:name => "someplace")
      Location.stub!(:find)
      post :create, :event => { "location" => "someplace" }
    end
    
    context "when successful" do
    
      before(:each) do
        Event.stub!(:new).
              and_return(@event)
        @event.should_receive(:save).
              and_return(true)
        post :create, :event => {}
      end

      specify { flash[:notice].should == "The event was saved successfully" }

      it "should redirect to the event" do
        pending("i can figure rspec out")
        response.should render_template( 'show' )
      end
    
    end
    
    context "when unsuccessful" do
      
      before(:each) do
        Event.stub!(:new).
              and_return(@event)
        @event.should_receive(:save).
              and_return(false)
        post :create, :event => {}
      end
      
      specify { pending("i can figure rspec out"); response.should render_template( 'new' ) }
      
    end
    
  end
  
  describe "index" do
    
    it "should find all events" do
      Event.should_receive(:find).
            and_return([@event])
      get :index
    end
    
    it "should assign found events to view" do
      Event.stub!(:find).
            and_return([@event])
      get :index
      assigns[:events].should == [@event]
    end

  end

end
