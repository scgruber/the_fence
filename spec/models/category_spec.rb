require 'spec_helper'

describe Category do
  
  subject { Factory(:category, :name => "myname") }
  let(:noun) { Factory(:category, :kind => "noun") }
  let(:adjective) { Factory(:category, :kind => "adjective") }
  
  describe "events" do
    
    it "should be buildable" do
      valid_event_attributes = Factory.attributes_for(:event)
      event = subject.events.create!(valid_event_attributes)
      event.categories.should include(subject)
    end
    
    it "should be accessible" do
      valid_event_attributes = Factory.attributes_for(:event)
      event = subject.events.create!(valid_event_attributes)
      subject.events.should include(event)
    end
    
  end

  its(:id) { should == "myname" }
  
  describe "noun scope" do
    
    subject { Category.noun }
    
    it { should include(noun) }
    
    it { should_not include(adjective) }
    
    it "should be sorted by name ascending" do
      higher_noun = Factory(:category, :kind => "noun", :name => "zzz-noun")
      lower_noun = Factory(:category, :kind => "noun", :name => "aaa-noun")
      
      nouns = subject.to_a
      
      nouns.index(higher_noun).should be > nouns.index(lower_noun)
    end
    
  end
  
  describe "adjective scope" do
    
    subject { Category.adjective }
    
    it { should_not include(noun) }
    
    it { should include(adjective) }
    
    it "should be sorted by name ascending" do
      higher_adjective = Factory(:category, :kind => "adjective", :name => "zzz-adj")
      lower_adjective = Factory(:category, :kind => "adjective", :name => "aaa-adj")
      
      adjectives = subject.to_a
      
      adjectives.index(higher_adjective).should be > adjectives.index(lower_adjective)
    end
    
  end

end