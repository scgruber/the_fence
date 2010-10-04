Feature: Event creation
  In order advertise my great event
  As an event organizer
  I want to create an event listing

  Scenario: Not logged in
    Given I am logged out
    When I go to the new event page
    Then I should be on the login page
    And I should see "Sign in"
		When I fill out the login form
		And I should see "You must be logged in to create a new event."
		And I press "Sign in"
		Then I should be on the new event page

  Scenario: Creating a valid event
    Given I am logged in
    And I am on the new event page
    And there is a location called "Doherty Hall 1212"
    When I fill in the following:
      | Name        | First Team Captain Meeting                                                  |
      | Where?      | Doherty Hall 1212                                                           |
      | From        | September 17 2009 4:30 PM                                                   |
      | To          | September 17 2009 5:30 PM                                                   |
      | Description | Come sign up for the limited tents and food tables! Snacks will be provided |
      | Cost        | $5                                                                          |
    And I attach the file "spec/fixtures/poster.gif" to "Poster"
    And I press "Create Event"
    Then I should see "The event was saved successfully"
    And I should see "First Team Captain Meeting"
    And I should see "Doherty Hall 1212"
    And I should see "4:30"
    And I should see "5:30"
    And I should see "Come sign up for the limited tents and food tables! Snacks will be provided"
    And I should see "$5"
		And I should see an image with value /poster.gif/

  Scenario: Creating a blank event
    Given I am logged in
    And I am on the new event page
    And I press "Create Event"
    Then I should see "Name can't be blank"
    And I should see "Location can't be blank"
    And I should see "Start can't be blank"

  Scenario: Creating event with start time after end time
    Given I am logged in
    And I am on the new event page
    When I fill in "December 12 2012" for "From"
    And I fill in "October 10 2010" for "To"
    And I press "Create Event"
    Then I should see "Finish should be after start time"

  Scenario: Uploading a poster of an unsupported type
    Given I am logged in
    And I am on the new event page
    When I attach the file "spec/fixtures/not_an_image.txt" to "Poster"
    And I press "Create Event"
    Then I should see "Image uploads must be a .jpg, .gif, or .png file."
		And I should not see "not_an_image.txt"
  
  Scenario: Selecting categories
    Given I am logged in
    And there is a noun category called "Fiesta"
    And there is a noun category called "Potluck"
		And there is an adjective category called "Casual"
		And there is an adjective category called "Crunk"
    And I am on the new event page
    And I enter valid event input
    When I check "Fiesta"
    And I check "Potluck"
		And I check "Casual"
		And I check "Crunk"
    And I press "Create Event"
    Then I should see "fiesta"
    And I should see "potluck"
		And I should see "casual"
		And I should see "crunk"
		And I should see "A casual, crunk fiesta/potluck"

	Scenario: Adding a textual cost
		Given I am logged in
    And I am on the new event page
    And I enter valid event input
		And I fill in "an arm and a leg" for "Cost"
		When I press "Create Event"
		Then I should see "an arm and a leg"
  
  Scenario: Til whenever events
    Given I am logged in
    And I am on the new event page
    And I enter valid event input
		When I fill in "October 10 2010" for "To"
    And I check "'Til Whenever"
    And I press "Create Event"
    Then I should see "Whenever"
		And I should not see "10/10/10"

	Scenario: Free events
		Given I am logged in
    And I am on the new event page
    And I enter valid event input
		When I fill in "a lot" for "Cost"
    And I check "Free"
    And I press "Create Event"
    Then I should see "Free"
		And I should not see "a lot"