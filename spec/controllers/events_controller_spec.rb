require 'spec_helper'

describe EventsController do
  
  before(:each) do
    @event = Factory.build(:event)
  end

  it "should assign @event on new" do
    Event.should_receive(:new).and_return(@event)
    get :new
    assigns[:event].should == @event
  end
  
  it "should create a new event" do
    Event.should_receive(:new).
          with("name" => "event").
          and_return(@event)
    post :create, :event => { "name" => "event" }
  end
  
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
      post :create
    end
    
    specify { flash[:notice].should == "The event was saved successfully" }
    
    it { should redirect_to(events_path) }
    
  end

end
