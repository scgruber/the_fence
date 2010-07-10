require 'spec_helper'

describe Category do

  describe "name" do
    
    it "should be id" do
      category = Factory(:category, :name => "myname")
      
      category.id.should == "myname"
    end
    
  end
  
  describe "noun scope" do
    
    before do
      @noun = Factory(:category, :kind => "noun")
      @adjective = Factory(:category, :kind => "adjective")
    end
    
    it "should contain nouns" do
      Category.noun.should include(@noun)
    end
    
    it "shouldn't contain adjectives" do
      Category.noun.should_not include(@adjective)
    end
    
  end
  
  describe "adjective scope" do
    
    before do
      @noun = Factory(:category, :kind => "noun")
      @adjective = Factory(:category, :kind => "adjective")
    end
    
    it "shouldn't contain nouns" do
      Category.adjective.should_not include(@noun)
    end
    
    it "should contain adjectives" do
      Category.adjective.should include(@adjective)
    end
    
  end

end