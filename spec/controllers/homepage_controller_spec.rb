require 'spec_helper'

describe HomepageController do

  let(:events) { [mock_model(Event)] }

  it "should find the featured events" do
    Event.should_receive(:featured).
          and_return(events)
    get :index
  end
  
  it "should assign the featured events to the view" do
    Event.stub(:featured => events)
    get :index
    assigns[:featured].should == events
  end

end
