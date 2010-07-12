require 'spec_helper'

describe HomepageController do

  it "should find the featured events" do
    # TODO: clean up mess. Maybe another scope?
    criteria = mock('Criteria')
    Event.stub_chain(:featured, :desc => criteria)
    criteria.should_receive(:all).
             and_return([@event])
    get :index
  end
  
  it "should assign the featured events to the view" do
    Event.stub_chain(:featured, :desc, :all).
          and_return([@event])
    get :index
    assigns[:featured].should == [@event]
  end

end
