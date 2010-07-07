require 'spec_helper'

describe EventsController do
  
  include Devise::TestHelpers
  
  before(:each) do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@current_user)
    @event = Factory.build(:event)
    @category = Factory(:category)
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
    
    it "should retrieve all categories to select from" do
      Category.should_receive(:find).
               and_return([@category])
      get :new
    end
    
    it "should assign all categories to the view" do
      Category.stub!(:find).
               and_return([@category])
      get :new
      assigns[:categories].should include(@category)
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
  
  describe "edit" do
    
    it "should find the requested event" do
      Event.should_receive(:find).
           with("my-event")
      get :edit, :id => "my-event"
    end
    
    it "should assign the requested event to view" do
      Event.stub!(:find).
           and_return(@event)
      get :edit, :id => "my-event"
      assigns[:event].should == @event
    end
    
  end
  
  describe "update" do
    
    it "should find the requested event" do
      Event.should_receive(:find).
            with("my-event").
            and_return(@event)
      post :update, :id => "my-event", :event => {}
    end
    
    it "should update attributes of the requested event" do
      Event.stub!(:find).
            and_return(@event)
      @event.should_receive(:update_attributes).
             with(hash_including("foo" => "bar"))
      post :update, :id => 1, :event => {"foo" => "bar"}
    end
    
    it "should assign the requested event to view" do
      Event.stub!(:find).
            and_return(@event)
      post :update, :id => 1, :event => {}
      assigns[:event].should == @event
    end
    
    it "should blank out finish if til_whenever checked" do
      Event.stub!(:find).
            and_return(@event)
      @event.should_receive(:update_attributes).
             with(hash_including(:finish => nil))
    
      post :update, :id => 1, :event => { :finish => "5:30", :til_whenever => "1" }
    end
    
    it "should locate the related location" do
      pending("habtm support in mongoid")
      Location.should_receive(:find_or_create_by).
               with(:name => "someplace")
      Location.stub!(:find)
      post :update, :id => 1, :event => { "location" => "someplace" }
    end
    
    context "when successful" do
      
      before(:each) do
        Event.stub!(:find).
              and_return(@event)
        @event.stub!(:save).
               and_return(true)
        post :update, :id => 1, :event => {}
      end
      
      specify { flash[:notice].should == "The event was successfully updated." }
      
      it "should redirect to the event" do
        pending("i can figure rspec out")
      end
      
    end
    
    context "when unsuccessful" do
      
      before(:each) do
        Event.stub!(:find).
              and_return(@event)
        @event.stub!(:save).
               and_return(false)
        post :update, :id => 1, :event => {}
      end
      
      it "should redirect to the edit page" do
        pending("i can figure rspec out")
      end
      
    end
    
  end
  
  describe "create" do
  
    it "should create a new event with parameters" do
      Event.should_receive(:new).
            with(hash_including("name" => "event")).
            and_return(@event)
      post :create, :event => { "name" => "event" }
    end
    
    it "should assign the created event to view" do
      Event.stub!(:new).
            and_return(@event)
      post :create, :event => {}
      assigns[:event].should == @event
    end
    
    it "should run validation when til_whenever unchecked"
    
    it "should blank out finish if til_whenever checked" do
      Event.should_receive(:new).
            with(hash_including(:finish => nil)).
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
    
    it "should assign the current user to creator" do
      Event.should_receive(:new).
            with(hash_including(:creator_id => @current_user.id)).
            and_return(@event)
      post :create, :event => {}
    end
    
    context "when successful" do
    
      before(:each) do
        Event.stub!(:new).
              and_return(@event)
        @event.should_receive(:save).
              and_return(true)
        post :create, :event => {}
      end

      specify { flash[:notice].should == "The event was saved successfully." }

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
