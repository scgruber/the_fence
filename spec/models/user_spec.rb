require 'spec_helper'

describe User do

  subject { Factory(:user) }

  describe "events" do
    
    it "are buildable" do
      valid_event_attributes = Factory.attributes_for(:event)
      event = subject.events.create!(valid_event_attributes)
      event.creator.should == subject
    end

    it "are accessible" do
      valid_event_attributes = Factory.attributes_for(:event)
      event = subject.events.create!(valid_event_attributes)
      subject.events.should include(event)
    end
    
  end
  
  describe "admin?" do
    
    it "defaults to false" do
      should_not be_admin
    end
    
  end

end
