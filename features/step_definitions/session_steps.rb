def user
  @user ||= Factory(:user)
end

Given /^I sign up as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  Given %{I go to signup}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I fill in "user_password_confirmation" with "#{password}"}
  And %{I press "Sign up"}
end

When /^I fill out the login form with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  When %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
end

When /^I fill out the login form$/ do
  When %{I fill out the login form with email "#{user.email}" and password "#{user.password}"}
  @current_user = user
end

Given /^I log in$/ do
  Given %{I am logged out}
  And %{I go to login}
  And %{I fill out the login form}
  And %{I press "Sign in"}
end

Given /^I am logged in$/ do
  unless @current_user
    Given %{I log in}
  end
end

Given /^I am logged out$/ do
  visit('/users/sign_out')
  @current_user = nil
end