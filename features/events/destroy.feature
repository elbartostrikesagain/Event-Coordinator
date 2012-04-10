Feature: New Event
  Creating new events

    Scenario: User creates a main event
      Given I am logged in
      And I have created a main event
      And I have created an event
      And I am on the main event's home page
      When I follow "List Events"
      And I follow "Destroy"
      Then I should not see the event
