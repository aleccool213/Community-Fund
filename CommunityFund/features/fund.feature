Feature: Funding a project

  Scenario: A user should be able to fund an open project and edit their donation
    Given a project exists
    And I have created a user account
    When I go to the "Login Page"
    Then I fill in my login details
    And I should see "Dashboard"
    Then I go to the "newest project"
    And I should see "Fund this"
    And I click on the "funding_button" link
    And I create a donation
    Then I should see my donation
    Then I click on the "edit_funding_button" link
    Then I edit my donation
    Then I should see my donation has changed

  Scenario: A user should not be able to edit their fund after a project has closed
    Given a project has been closed
    When I go to the "newest project"
    Then I should see "Project Closed"
    Given I have created a user account
    When I go to the "Login Page"
    And I fill in my login details
    Then I go to the "newest project"
    Then I should see "Project Closed"