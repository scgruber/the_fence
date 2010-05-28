Feature: Event creation
  In order advertise my great event
  As an event organizer
  I want to create an event listing

  @allow-rescue
  Scenario: Not logged in
    Given I am not logged in
    When I go to the new event page
    Then I should be on the login page
    And I should see "Log in"

  Scenario: Creating a valid event
    Given I am logged in
    And I am on the new event page
    And there is a location called "Doherty Hall 1212"
    When I fill in the following:
      | Name        | First Team Captain Meeting                                                  |
      | Slogan      | Save these dates!                                                           |
      | Where?      | Doherty Hall 1212                                                           |
      | From        | 9/17/09 at 4:30 PM                                                          |
      | To          | 9/17/09 at 5:30 PM                                                          |
      | Description | Come sign up for the limited tents and food tables! Snacks will be provided |
      | Cost        | 5.00                                                                        |
    And I attach the "image/jpeg" file at "spec/fixtures/poster.gif" to "Poster"
    And I press "Create Event"
    Then I should see "Event was successfully created."
    And I should see "First Team Captain Meeting"
    And I should see "Save these dates!"
    And I should see "Doherty Hall 1212"
    And I should see "4:30"
    And I should see "5:30"
    And I should see "Come sign up for the limited tents and food tables! Snacks will be provided"
    And I should see "$5"

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
    When I fill in "12/12/12" for "From"
    And I fill in "10/10/10" for "To"
    And I press "Create Event"
    Then I should see "Finish should be after start time"

  Scenario: Uploading a poster of an unsupported type
    Given I am logged in
    And I am on the new event page
    When I attach the "text/plain" file at "spec/fixtures/not_an_image.txt" to "Poster"
    And I press "Create Event"
    Then I should see "Poster uploads must be a .jpg, .gif, or .png file."
  
  Scenario: Selecting categories
    Given I am logged in
    And there is a category called "Fiesta"
    And there is a category called "Potluck"
    And I am on the new event page
    And I enter valid event input
    When I check "Fiesta"
    When I check "Potluck"
    And I press "Create Event"
    Then I should see "Fiesta"
    And I should see "Potluck"
  
  Scenario: Til whenever events
    Given I am logged in
    And I am on the new event page
    And I enter valid event input
    When I check "'Til Whenever"
    And I press "Create Event"
    Then I should see "Whenever"
    
  Scenario: Free Events
    Given I am logged in
    And I am on the new event page
    And I enter valid event input
    When I check "Free"
    And I press "Create Event"
    Then I should see "Free"
