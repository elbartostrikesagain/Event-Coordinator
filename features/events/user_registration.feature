Feature: Registering users for shifts
    As an event admin
    I want to manange users shifts
    So I can more control

  Scenario: Regular user should not see admin options
    Given I am logged in
    And a main event exists
    And An event exists
    And I am on the the main event's list shifts page
    Then I should not see "Edit workers" within "#shifts"
    And I should not see "Edit" within "#shifts"
    And I should not see "Destroy" within "#shifts"

  Scenario: Regular user be able to register and unregister from shifts
    Given I am logged in
    And a main event exists
    And An event exists
    And I am on the the main event's list shifts page
    When I follow "Sign up" within "#shifts"
    Then I should be registered with the event
    When I follow "Unregister" within "#shifts"
    Then I should see "Sign up" within "#shifts"
    And I should not be registered with the event

  @javascript
  Scenario: Admin user can modify the registered users from shifts
    Given I am logged in
    And I have created a main event
    And I have created an event
    And I am on the the main event's list shifts page
    And A user is registered with the main event
    When I follow "Edit workers"
    And I search for the user
    And I follow "(add)"
    Then the user should be registered for the shift
    When I follow "(remove)"
    Then the user should should not be registered for the shift
