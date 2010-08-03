Feature: Event searching
  In order to find events that suit my mood
  As an event-seeker
  I want to search for events

	Scenario: Searching by tags
		Given there is a noun category called "Fiesta"
		And an existing event named "Great Party" with category "Fiesta"
		When I go to the home page
		And I check "Fiesta" within ".mood-select"
		And I press "Find events"
		Then I should see "Great Party"
	
	Scenario: Searching by tags with no matching events
		Given there is a noun category called "Lecture"
		And an existing event named "Some Party" with category "Fiesta"
		When I go to the home page
		And I check "Lecture" within ".mood-select"
		And I press "Find events"
		Then I should not see "Some Party"
	
	Scenario: Full text search
		Given an existing event named "My Event" with description "Wow, it's great."
		When I go to the home page
		And I fill in "Wow" for "query" within ".search-field"
		And I press "Search"
		Then I should see "My Event"