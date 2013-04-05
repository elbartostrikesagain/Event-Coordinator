Feature: New Main Event
  Creating new Main Events

    Scenario: User creates a main event
      Given I am logged in
      And I am on the main events page
      And I follow "Create a new event to coordinate »"
      And I fill in "Name" with "My Event"
      And I wait for the html editor to load
      And I fill in "html" with "Hello World"
      And I press "Save"
      Then I should see "Main event was successfully created."
      And I should see "My Event"
      And I should see "Hello World"
