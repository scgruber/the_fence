Feature: Featured events
  In order to put things on the front page
  As an administrator
  I want to be able to make events featured

	Scenario: As admin
		Given I am logged in as an admin
		When I go to the new event page
		And I enter valid event input
		And I check "Featured"
		When I fill in "My Great Event" for "Name"
		And I submit the event creation form
		And I go to the home page
		Then I should see "My Great Event"
		
		When I go to the event's edit page
		And I uncheck "Featured"
		And I press "Update Event"
		And I go to the home page
		Then I should not see "My Great Event"
	
	Scenario: Not as admin
		Given I am logged in as a user
		When I go to the new event page
		Then I should not see "Featured"
		And I should not see "Page Rank"
		
		Given an existing event
		When I go to the event's edit page
		Then I should not see "Featured"
		And I should not see "Page Rank"
	
	Scenario: Multiple featured events
		Given I am logged in as an admin
		
		# Create Event #1
		When I go to the new event page
		And I enter valid event input
		And I fill in "Event 1" for "Name"
		And I check "Featured"
		And I fill in "1" for "Page Rank"
		And I submit the event creation form
		
		# Create Event #2
		When I go to the new event page
		And I enter valid event input
		And I fill in "Event 2" for "Name"
		And I check "Featured"
		And I fill in "0" for "Page Rank"
		And I submit the event creation form
		
		And I go to the home page
		Then I should see "Event 1" within ".featured"
		And I should see "Event 2" within ".list"
		
		# Re-rank Event #2
		When I go to the event's edit page
		And I fill in "2" for "Page Rank"
		And I press "Update Event"
		
		And I go to the home page
		Then I should see "Event 2" within ".featured"
		And I should see "Event 1" within ".list"