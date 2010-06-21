Given /^I sign up as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  Given %{I go to signup}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I fill in "user_password_confirmation" with "#{password}"}
  And %{I press "Sign up"}
end

Given /^I log in as an example user/ do
  email = 'testing@man.net'
  login = 'Testing man'
  password = 'secretpass'

  Given %{I sign up as "#{email}" with password "#{password}"}
  And %{I am logged out}
  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end

Given /^I am logged in$/ do
  unless @user
    Given %{I log in as an example user}
  end
end

Given /^I am logged out$/ do
  visit('/users/sign_out')
end