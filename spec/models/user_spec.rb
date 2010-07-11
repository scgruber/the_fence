require 'spec_helper'

describe User do

  it "should allow the building of events" do
    pending("mongoid does belongs_to builds correctly")
    user = Factory(:user)
    valid_event_attributes = Factory.attributes_for(:event)
    event = user.events.build(valid_event_attributes)
    event.creator.should == user
  end
  
  describe "admin?" do
    
    it "should default to false" do
      user = Factory(:user)
      user.admin?.should == false
    end
    
  end

end
