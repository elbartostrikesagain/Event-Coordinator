Feature: Edit Main Event
  Editing Main Events

    Scenario: User edits a main event
      Given I am logged in
      And I have created a main event
      And I am on the main events page
      When I follow "Edit" within "#events"
      Then I should be editing the main event
      When I fill in "Name" with "testing update"
      When I press "Save"
      Then the events name should be "testing update"
