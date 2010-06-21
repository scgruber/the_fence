Feature: Event editing
  In order to keep my information current
  As an event organizer
  I want to edit an event listing

	@allow-rescue
  Scenario: Not logged in
    Given I am logged out
    And an existing event not created by me
    When I go to the event's edit page
    Then I should be on the login page
    And I should see "Sign in"
    
  Scenario: Edit event
    Given I am logged in
    And an existing event owned by me
    And there is a location called "Porter Hall 100"
    When I go to the event's edit page
    And I fill in the following:
      | Name        | Second Team Captain Meeting                                                     |
      | Slogan      | Now revised!                                                                    |
      | Where?      | Porter Hall 100                                                                 |
      | From        | 9/20/09 at 5:30 PM                                                              |
      | To          | 9/20/09 at 6:30 PM                                                              |
      | Description | Come sign up for the limited tents and food tables! Snacks will not be provided |
      | Cost        | 10.00                                                                           |
    And I attach the "image/jpeg" file at "spec/fixtures/poster.gif" to "Poster"
    And I press "Update Event"
    Then I should see "Event was successfully updated."
    And I should see "Second Team Captain Meeting"
    And I should see "Now revised!"                                                   
    And I should see "Porter Hall 100"                                                                
    And I should see "5:30"                                                             
    And I should see "6:30"                                                            
    And I should see "Come sign up for the limited tents and food tables! Snacks will not be provided"
    And I should see "$10"
    
  Scenario: Creating event with start time after end time
    Given I am logged in
    And an existing event owned by me
    When I go to the event's edit page
    And I fill in "12/12/12" for "From"
    And I fill in "10/10/10" for "To"
    And I press "Update Event"
    Then I should see "Finish should be after start time"

  Scenario: Uploading a poster of an unsupported type
    Given I am logged in
    And an existing event owned by me
    When I go to the event's edit page
    And I attach the "text/plain" file at "spec/fixtures/not_an_image.txt" to "Poster"
    And I press "Update Event"
    Then I should see "Poster uploads must be a .jpg, .gif, or .png file."

  Scenario: Selecting categories
    Given I am logged in
    And there is a category called "Lecture"
    And there is a category called "Panel"
    And an existing event owned by me
    And I am on the event's edit page
    When I check "Lecture"
    And I check "Panel"
    And I press "Update Event"
    Then I should see "Lecture"
    And I should see "Panel"
		When I go to the event's edit page
		Then the "Lecture" checkbox should be checked
		And the "Panel" checkbox should be checked

  Scenario: Til whenever events
    Given I am logged in
    And an existing event owned by me
    And I am on the event's edit page
    When I check "'Til Whenever"
    And I press "Update Event"
    Then I should see "Whenever"
		When I go to the the event's edit page
		Then the "'Til Whenever" checkbox should be checked