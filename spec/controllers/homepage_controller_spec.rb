require 'spec_helper'

describe HomepageController do

  let(:events) { [mock_model(Event)] }

  it "finds the featured events" do
    Event.should_receive(:featured).
          and_return(events)
    get :index
  end
  
  it "assigns the featured events to the view" do
    Event.stub(:featured => events)
    get :index
    assigns[:featured].should == events
  end

end
