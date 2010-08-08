require 'spec_helper'

describe User do

  subject { Factory(:user) }

  describe "events" do
    
    it "should be buildable" do
      valid_event_attributes = Factory.attributes_for(:event)
      event = subject.events.create!(valid_event_attributes)
      event.creator.should == subject
    end

    it "should be accessible" do
      valid_event_attributes = Factory.attributes_for(:event)
      event = subject.events.create!(valid_event_attributes)
      subject.events.should include(event)
    end
    
  end
  
  describe "admin?" do
    
    it "should default to false" do
      should_not be_admin
    end
    
  end

end
