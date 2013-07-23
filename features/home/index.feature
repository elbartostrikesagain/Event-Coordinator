Feature: Home page
  As a potential user, I want to see why I should use event overlord
    Scenario: Potential users wants to see how many hours event overlord has been used for
      Given a shift with "2.55" hours exists
      And an all day shift exists
      And I am on the home page
      Then I should see "12.5 hours"
