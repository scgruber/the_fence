require 'spec_helper'

describe EventsController do
  
  let(:event) { mock_model(Event, :update_attributes => true, :save => true) }
  let(:categories) { [mock_model(Category)] }
  
  before :all do
    @current_user = Factory(:user)
  end
  
  before do
    event.stub(:creator => @current_user)
    Event.stub(:find => event)

    controller.stub!(:current_user => @current_user, :user_signed_in? => true)
    # sign_in :user, @current_user # TODO figure out why this doesn't work
  end

  describe "new" do

    it "create a new event" do
      Event.should_receive(:new).
            and_return(event)
      get :new
    end
    
    it "should assign a new event to view" do
      Event.stub!(:new).
            and_return(event)
      get :new
      assigns[:event].should == event
    end
    
    it "should retrieve all categories to select from" do
      Category.should_receive(:find).
               and_return(categories)
      get :new
    end
    
    it "should assign all categories to the view" do
      Category.stub(:find => categories)
      get :new
      assigns[:categories].should == categories
    end
    
  end
  
  describe "show" do
    
    it "should find the requested event" do
      Event.should_receive(:find).
           with("my-event")
      get :show, :id => "my-event"
    end
    
    it "should assign the requested event to view" do
      get :show, :id => "my-event"
      assigns[:event].should == event
    end
    
  end
  
  describe "edit" do
    
    it "should find the requested event" do
      Event.should_receive(:find).
           with("my-event")
      get :edit, :id => "my-event"
    end
    
    it "should assign the requested event to view" do
      get :edit, :id => "my-event"
      assigns[:event].should == event
    end
    
    it "should render the edit template" do
      get :edit, :id => "my-event"
      response.should render_template("edit")
    end
    
    context "when not creator" do
      
      before(:each) do
        event.stub(:creator => nil)
        get :edit, :id => "my-event"
      end
      
      it "should redirect to homepage" do
        response.should redirect_to(root_path)
      end
      
      specify { flash[:alert].should == "You must be logged in as the event's owner to edit it." }
      
    end
    
  end
  
  describe "update" do
    
    it "should find the requested event" do
      Event.should_receive(:find).
            with("my-event").
            and_return(event)
      put :update, :id => "my-event", :event => {}
    end
    
    it "should update attributes of the requested event" do
      event.should_receive(:update_attributes).
             with(hash_including("foo" => "bar"))
      put :update, :id => 1, :event => {"foo" => "bar"}
    end
    
    it "should assign the requested event to view" do
      put :update, :id => 1, :event => {}
      assigns[:event].should == event
    end
    
    it "should locate the related location" do
      pending("habtm support in mongoid")
      Location.should_receive(:find_or_create_by).
               with(:name => "someplace")
      Location.stub!(:find)
      put :update, :id => 1, :event => { "location" => "someplace" }
    end
    
    context "when not creator" do
      
      before(:each) do
        event.stub(:creator => nil)
        put :update, :id => 1, :event => {}
      end
      
      it "should redirect to homepage" do
        response.should redirect_to(root_path)
      end
      
      specify { flash[:alert].should == "You must be logged in as the event's owner to edit it." }
      
    end
    
    context "when successful" do
      
      before do
        event.stub(:update_attributes => true)
        put :update, :id => 1, :event => {}
      end
      
      specify { flash[:notice].should == "The event was successfully updated." }
      
      it "should redirect to the event" do
        response.should redirect_to(event_path(event))
      end
      
    end
    
    context "when unsuccessful" do
      
      before do
        event.stub(:update_attributes => false)
        event.errors.stub(:empty? => false)  # TODO: check to see if RSpec does this yet
        put :update, :id => 1, :event => {}
      end
      
      it "should re-render the 'edit' template" do
        response.should render_template('edit')
      end
      
    end
    
  end
  
  describe "create" do
  
    before do
      Event.stub(:new => event)
      event.stub(:creator => nil, :creator= => nil)
    end
  
    it "should create a new event with parameters" do
      Event.should_receive(:new).
            with(hash_including("name" => "event")).
            and_return(event)
      post :create, :event => { "name" => "event" }
    end
    
    it "should assign the created event to view" do
      post :create, :event => {}
      assigns[:event].should == event
    end
    
    it "should locate the related location" do
      pending("habtm support in mongoid")
      Location.should_receive(:find_or_create_by).
               with(:name => "someplace")
      Location.stub!(:find)
      post :create, :event => { "location" => "someplace" }
    end
    
    it "should assign the current user to creator" do
      event.should_receive(:creator=).
             with(@current_user)

      post :create, :event => {}
    end
    
    context "when successful" do
    
      before do
        event.stub(:save => true)
        post :create, :event => {}
      end

      specify { flash[:notice].should == "The event was saved successfully." }

      it "should redirect to the event" do
        response.should redirect_to(event_path(event))
      end
    
    end
    
    context "when unsuccessful" do
      
      before do
        event.stub(:save => false)
        event.errors.stub(:empty? => false) # TODO: check to see if RSpec does this yet
        post :create, :event => {}
      end
      
      it "should show the re-render 'new' template" do
        response.should render_template("new")
      end
      
    end
    
  end
  
  describe "index" do
    
    let(:events) { [event] }
    
    before do
      Event.stub(:all => events)
    end
    
    it "should find all events" do
      Event.should_receive(:all).
            and_return(events)
      get :index
    end
    
    it "should assign found events to view" do
      get :index
      assigns[:events].should == events
    end
    
    context "when a search query is provided" do
      
      it "should filter by name" do
        events.should_receive(:where).
                with(:name => /Fiesta/i).
                and_return(events)
        get :index, :query => "Fiesta"
      end
      
    end
    
    context "when category ids are provided" do
      
      it "should filter by the provided category ids" do
        events.should_receive(:any_in).
                with(:category_ids => ["party", "lecture"]).
                and_return(events)
        get :index, :category_ids => ["party", "lecture"]
      end
      
      it "should assign filtered contents to view" do
        events.should_receive(:any_in).
                and_return(events)
        get :index, :category_ids => []
        assigns[:events].should == events
      end
      
    end

  end

end
