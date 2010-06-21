Given /^I sign up as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  Given %{I go to signup}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I fill in "user_password_confirmation" with "#{password}"}
  And %{I press "Sign up"}
end

Given /^I log in as an example user/ do
  Given %{I am logged out}
  @current_user = Factory(:user)
  Given %{I go to login}
  And %{I fill in "user_email" with "#{@current_user.email}"}
  And %{I fill in "user_password" with "#{@current_user.password}"}
  And %{I press "Sign in"}
end

Given /^I am logged in$/ do
  unless @current_user
    Given %{I log in as an example user}
  end
end

Given /^I am logged out$/ do
  visit('/users/sign_out')
  @current_user = nil
end