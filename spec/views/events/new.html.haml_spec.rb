require 'spec_helper'

describe "events/new.html.haml" do
  
  it "should display flash[:error]" do
    pending("rspec-rails gets flash support")
    flash[:error] = "some error string"
    render
    response.should include("some error string")
  end
  
  it "should display flash[:notice]" do
    pending("rspec-rails gets flash support")
    flash[:notice] = "some notification"
    render
    response.should include("some notification")
  end
  
  it "should render" do
    pending("rspec-rails gets flash support")
    assigns[:event] = Factory(:event)
    render
  end
  
end