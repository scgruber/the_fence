Given /^I enter valid event input$/ do
  Given %{I fill in "Name" with "First Team Captain Meeting"}
  Given %{I fill in "Where?" with "Doherty Hall 1212"}
  Given %{I fill in "From" with "September 17 2009 4:30 PM"}
  Given %{I fill in "To" with "September 17 2009 5:30 PM"}
  Given %{I fill in "Description" with "Come sign up for the limited tents and food tables! Snacks will be provided"}
  Given %{I fill in "Cost" with "5.00"}
end

Given /^there is (?:a|an) (\w+) category called "([^\"]*)"$/ do |kind, name|
  Factory(:category, :name => name, :kind => kind.downcase)
end

Given /^an existing event named "([^\"]*)" with category "([^\"]*)"$/ do |name, category|
  Given %{an existing event named "#{name}"}
  @event.categories << Category.where(:name => category)
  @event.save
end

Given /^an existing event named "([^\"]*)" with description "([^\"]*)"$/ do |name, description|
  Given %{an existing event named "#{name}"}
  @event.description = description
  @event.save
end

Given /^an existing event named "([^\"]*)"$/ do |name|
  Given %{an existing event created by me}
  @event.name = name
  @event.save
end

Given /^an existing event$/ do
  Given %{an existing event created by me}
end

Given /^an existing event not created by me$/ do
  Given %{an existing event}
  @event.update_attributes!(:creator => nil)
end

Given /^an existing event created by me$/ do
  @event = Factory(:event)
  @event.update_attributes!(:creator => user)
end

When /^I submit the event creation form$/ do
  When %{I press "Create Event"}
  @event = Event.last
end