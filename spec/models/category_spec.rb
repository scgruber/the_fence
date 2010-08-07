require 'spec_helper'

describe Category do

  describe "name" do
    
    it "should be id" do
      category = Factory(:category, :name => "myname")
      
      category.id.should == "myname"
    end
    
  end
  
  describe "noun scope" do
    
    subject { Category.noun }
    
    before do
      @noun = Factory(:category, :kind => "noun", :name => "bbb")
      @adjective = Factory(:category, :kind => "adjective")
    end
    
    it { should include(@noun) }
    
    it { should_not include(@adjective) }
    
    it "should be sorted by name ascending" do
      lower_noun = Factory(:category, :kind => "noun", :name => "aaa")
      
      nouns = subject.to_a
      nouns.index(@noun).should be > nouns.index(lower_noun)
    end
    
  end
  
  describe "adjective scope" do
    
    subject { Category.adjective }
    
    before do
      @noun = Factory(:category, :kind => "noun")
      @adjective = Factory(:category, :kind => "adjective", :name => "bbb")
    end
    
    it { should_not include(@noun) }
    
    it { should include(@adjective) }
    
    it "should be sorted by name ascending" do
      lower_adjective = Factory(:category, :kind => "adjective", :name => "aaa")
      
      adjectives = subject.to_a
      adjectives.index(@adjective).should be > adjectives.index(lower_adjective)
    end
    
  end

end