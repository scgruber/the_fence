require 'spec_helper'

describe "events/index.html.haml" do
  
  it "should display flash[:notice]" do
    pending("rspec-rails gets flash support")
    flash[:notice] = "some notification"
    render
    response.should include("some notification")
  end
  
  it "should render" do
    assigns[:events] = [Factory(:event)]
    expect { render }.should_not raise_error
  end
  
end