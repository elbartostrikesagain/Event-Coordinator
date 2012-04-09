Feature: New Event
  Creating new events

    Scenario: User creates a main event
      Given I am logged in
      And I have created a main event
      And I am on the main event's home page
      When I follow "List Events"
      And I follow "Add Event"
      And I fill in "Title" with "yay"
      And I press "Save"
      Then I should see "yay"
      And I should see "Event was successfully created."
