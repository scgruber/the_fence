Feature: Event editing
  In order to keep my information current
  As an event organizer
  I want to edit an event listing

	@allow-rescue
  Scenario: Not logged in
    Given I am logged out
    And an existing event created by me
    When I go to the event's edit page
    Then I should be on the login page
    And I should see "Sign in"
		When I fill out the login form
		And I should see "You must be logged in as the event's owner to edit it."
		And I press "Sign in"
		Then I should be on the event's edit page
    
  Scenario: Edit event
    Given I am logged in
    And an existing event created by me
    And there is a location called "Porter Hall 100"
    When I go to the event's edit page
    Then I should be on the event's edit page
    When I fill in the following:
      | Name        | Second Team Captain Meeting                                                     |
      | Where?      | Porter Hall 100                                                                 |
      | From        | September 17 2009 4:30 PM                                                       |
      | To          | September 17 2009 5:30 PM                                                       |
      | Description | Come sign up for the limited tents and food tables! Snacks will not be provided |
      | Cost        | $10                                                                             |

    And I attach the file "spec/fixtures/poster.gif" to "Poster"
    And I press "Update Event"
    Then I should see "The event was successfully updated."
    And I should see "Second Team Captain Meeting"                                              
    And I should see "Porter Hall 100"                                                                
    And I should see "4:30"                                                             
    And I should see "5:30"                                                            
    And I should see "Come sign up for the limited tents and food tables! Snacks will not be provided"
    And I should see "$10"
    
  Scenario: Creating event with start time after end time
    Given I am logged in
    And an existing event created by me
    When I go to the event's edit page
    And I fill in "December 12, 2012" for "From"
    And I uncheck "'Til Whenever"
    And I fill in "October 10, 2010" for "To"
    And I press "Update Event"
    Then I should see "Finish should be after start time"

  Scenario: Uploading a poster of an unsupported type
    Given I am logged in
    And an existing event created by me
    When I go to the event's edit page
    And I attach the file "spec/fixtures/not_an_image.txt" to "Poster"
    And I press "Update Event"
    Then I should see "Image uploads must be a .jpg, .gif, or .png file."

  Scenario: Selecting categories
    Given I am logged in
    And there is a noun category called "Cookout"
    And there is a noun category called "Luau"
    And there is an adjective category called "Formal"
    And there is an adjective category called "Educational"
    And an existing event created by me
    And I am on the event's edit page
    When I check "Cookout"
    And I check "Luau"
    And I check "Formal"
    And I check "Educational"
    And I press "Update Event"
    Then I should see "cookout"
    And I should see "luau"
    And I should see "formal"
    And I should see "educational"
    And I should see "An educational, formal cookout/luau"
    When I go to the event's edit page
    Then the "Cookout" checkbox should be checked
    And the "Luau" checkbox should be checked
    And the "Formal" checkbox should be checked
    And the "Educational" checkbox should be checked

	Scenario: Adding a textual cost
		Given I am logged in
		And an existing event created by me
		And I am on the event's edit page
		And I fill in "an arm and a leg" for "Cost"
		When I press "Update Event"
		Then I should see "an arm and a leg"

  Scenario: Til whenever events
    Given I am logged in
    And an existing event created by me
    And I am on the event's edit page
		When I fill in "October 10, 2010" for "To"
    And I check "'Til Whenever"
    And I press "Update Event"
    Then I should see "Whenever"
		And I should not see "October 10, 2010"
		When I go to the the event's edit page
		Then the "'Til Whenever" checkbox should be checked
	
  Scenario: Free events
    Given I am logged in
    And an existing event created by me
    And I am on the event's edit page
		When I fill in "a ton" for "Cost"
    And I check "Free"
    And I press "Update Event"
    Then I should see "Free"
		And I should not see "a ton"
		When I go to the the event's edit page
		Then the "Free" checkbox should be checked
	
	@allow-rescue
	Scenario: Editing someone else's event
		Given I am logged in
		And an existing event not created by me
		When I go to the event's edit page
		Then I should be on the home page
		And I should see "You must be logged in as the event's owner to edit it."
	
	Scenario: Editing someone else's event as an admin
		Given I am logged in as an admin
		And an existing event not created by me
		When I go to the event's edit page
		Then I should be on the event's edit page
		