require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  
  let(:user) { Factory(:user) }
  let(:event) { mock_model(Event).as_null_object }
  
  describe "of an anonymous user" do
  
    subject { Ability.new(nil) }
  
    it { should be_able_to(:read, event) }
    it { should_not be_able_to(:edit, event) }
  
  end
  
  describe "of a logged-in user" do
    
    subject { Ability.new(user) }
    
    it { should_not be_able_to(:delete, event) }
    
    context "who owns an event" do
      
      before { event.stub(:creator => user) }
      
      it { should be_able_to(:edit, event) }
      
    end
    
    context "who does not own an event" do
      
      it { should_not be_able_to(:edit, event) }
      
    end
    
  end
  
  describe "on an admin" do
    
    subject { Ability.new(user) }
    before { user.stub!(:admin? => true) }
    
    it { should be_able_to(:edit, event) }
    it { should be_able_to(:delete, event) }
    
  end  
  
end
