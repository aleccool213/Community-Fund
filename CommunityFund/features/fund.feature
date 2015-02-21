Feature: Funding a project

  Scenario: A user should be able to fund an open project
    Given a project exists
    And I have created a user account
    When I go to the "Login Page"
    Then I fill in my login details
    And I should see "Dashboard"
    Then I go to the "newest project"
    And I should see "Fund this"
    And I click on the "funding_button" link

  Scenario: A user should be able to edit their fund
  # TODO

  Scenario: An initiator should not be able to fund their own project
  # TODO

  Scenario: A user should not be able to edit their fund after a project has closed
  # TODO