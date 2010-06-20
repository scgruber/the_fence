require 'spec_helper'

describe Category do

  describe "name" do
    
    it "should be id" do
      category = Factory(:category, :name => "myname")
      
      category.id.should == "myname"
    end
    
  end

end