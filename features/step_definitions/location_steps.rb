Given /^there is a location called "([^\"]*)"$/ do |location_name|
  @location = Factory(:location, :name => location_name)
end