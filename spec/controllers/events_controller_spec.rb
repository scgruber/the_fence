require 'spec_helper'

describe EventsController do
  
  include Devise::TestHelpers
  
  before(:each) do
    @current_user = Factory(:user)     # TODO: Factory for now, but it might be really slow
    # sign_in :user, @current_user # TODO figure out why this doesn't work
    controller.stub!(:current_user => @current_user)
    controller.stub!(:user_signed_in? => true)
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
    
    before do
      @event.stub!(:creator_id => @current_user.id)
    end
    
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
    
    it "should render the edit template" do
      Event.stub!(:find).
           and_return(@event)
      get :edit, :id => "my-event"
      response.should render_template("edit")
    end
    
    context "when not creator" do
      
      before(:each) do
        Event.stub!(:find).
              and_return(@event)
        @event.stub!(:creator_id => nil)
        get :edit, :id => "my-event"
      end
      
      it "should redirect to homepage" do
        response.should redirect_to(root_path)
      end
      
      specify { flash[:alert].should == "You must be logged in as the event's owner to edit it." }
      
    end
    
  end
  
  describe "update" do

    before do
      @event.stub!(:creator_id => @current_user.id)
    end
    
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
    
    it "should locate the related location" do
      pending("habtm support in mongoid")
      Location.should_receive(:find_or_create_by).
               with(:name => "someplace")
      Location.stub!(:find)
      post :update, :id => 1, :event => { "location" => "someplace" }
    end
    
    context "when not creator" do
      
      before(:each) do
        Event.stub!(:find).
              and_return(@event)
        @event.stub!(:creator_id => nil)
        post :update, :id => 1, :event => {}
      end
      
      it "should redirect to homepage" do
        response.should redirect_to(root_path)
      end
      
      specify { flash[:alert].should == "You must be logged in as the event's owner to edit it." }
      
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
    
    it "should locate the related location" do
      pending("habtm support in mongoid")
      Location.should_receive(:find_or_create_by).
               with(:name => "someplace")
      Location.stub!(:find)
      post :create, :event => { "location" => "someplace" }
    end
    
    it "should assign the current user to creator" do
      Event.should_receive(:new).
            with(hash_including(:creator => @current_user)).
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
    
    context "when category ids are provided" do
      
      it "should filter by the provided category ids" do
        Event.should_receive(:any_in).
              with(:category_ids => ["party", "lecture"]).
              and_return([@event])
        get :index, :category_ids => ["party", "lecture"]
      end
      
      it "should assign filtered contents to view" do
        Event.should_receive(:any_in).
              and_return([@event, @event]) # To differentiate it from the above, return two
        get :index, :category_ids => []
        assigns[:events].should == [@event, @event]
      end
      
    end

  end

end
