Feature: New Event
  Creating new events
    @javascript
    Scenario: User creates a new event
      Given I am logged in
      And I have created a main event
      And I am on the main event's home page
      When I follow "List Events"
      And I follow "Add Event"
      And I fill in "Title" with "yay"
      And I fill in "starts_at" with "04/13/2012 01:27 am"
      And I fill in "ends_at" with "04/13/2012 01:27 am"
      And I follow "Save"
      And show me the page
      Then I should see "yay"
      And I should see "Event was successfully created."
