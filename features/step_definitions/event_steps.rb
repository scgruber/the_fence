Given /^I enter valid event input$/ do
  Given %{I fill in "Name" with "First Team Captain Meeting"}
  Given %{I fill in "Where?" with "Doherty Hall 1212"}
  Given %{I fill in "From" with "9/17/09 at 4:30 PM"}
  Given %{I fill in "To" with "9/17/09 at 5:30 PM"}
  Given %{I fill in "Description" with "Come sign up for the limited tents and food tables! Snacks will be provided"}
  Given %{I fill in "Cost" with "5.00"}
end

Given /^there is a category called "([^\"]*)"$/ do |name|
  Factory(:category, :name => name)
end

Given /^an existing event$/ do
	@event = Factory(:event)
end

Given /^an existing event not created by me$/ do
  Given %{an existing event}
  @event.update_attributes!(:creator => nil)
end

Given /^an existing event created by me$/ do
  Given %{an existing event}
  @event.update_attributes!(:creator => @user)
end