require 'spec_helper'

describe EventsController do
  
  include Devise::TestHelpers # TODO remove when rspec wises up
  
  before(:each) do
    @event = Factory.build(:event)
  end

  describe "new" do

    it "should assign @event on new" do
      Event.should_receive(:new).and_return(@event)
      get :new
      assigns[:event].should == @event
    end
  
  it "should assign requested @event on show" do
    Event.should_receive(:find).
         with("my-event").
         and_return(@event)
    get :show, :id => "my-event"
    assigns[:event].should == @event
  end
  
  describe "show" do
  
  it "should locate the related location on create" do
    pending("habtm support in mongoid")
    Location.should_receive(:find_or_create_by).
             with(:name => "someplace")
    Location.stub!(:find)
    post :create, :event => { "location" => "someplace" }
  end
  
  describe "create" do
  
    it "should create a new event with parameters" do
      Event.should_receive(:new).
            and_return(@event)
      post :create, :event => { "name" => "event" }
    end
    
    it "should blank out finish if til_whenever checked" do
      Event.should_receive(:new).with(hash_including(:finish => nil))
    
      post :create, :event => { :finish => "5:30", :til_whenever => true }
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
        Event.should_receive(:new).
              and_return(@event)
        @event.should_receive(:save).and_return(true)
        post :create, :event => {}
      end

      specify { flash[:notice].should == "The event was saved successfully" }

      it { should redirect_to( event_path(@event) ) }
    
    end
    
  end
  
  describe "index" do
  
    it "should assign @events on index" do
      Event.should_receive(:find).and_return([@event])
      get :index
      assigns[:events].should == [@event]
    end

  end

end
