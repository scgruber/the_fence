require 'spec_helper'

describe Location do

  subject { Factory(:location) }

  it "should have its name for an id" do
    subject.id.should == subject.name.downcase
  end

end
