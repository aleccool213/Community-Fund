Feature: Projects

  Scenario: Log in, create and edit project
    Given I am on the "Home Page"
    And I have created a user account
    When I go to the "Login Page"
    Then I fill in my login details
    Then I should see "Dashboard"
    And I go to the "Create Project Page"
    And I fill in my project details
    And I click on the "submit_button" button
    Then the project info should be shown
    And I click on the "edit_button" link
    Then I should see the edit details
    And I edit the project
    Then I should see "Some new description"
    And I should see "of $1500.00"
    And I should not see "Fund this"
    And I should not see "Edit donation"
    And I should not see "Sign up to fund this"

  @javascript
  Scenario: Form validations
    Given I am on the "Home Page"
    And I have created a user account
    When I go to the "Login Page"
    Then I fill in my login details
    Then I should see "Dashboard"
    And I go to the "Create Project Page"
    And I click on the "submit_button" button
    Then I should see "Please enter a name"
    Then I should see "Please enter a description"
    Then I should see "Please enter an amount greater than $100"
    Then I should see "Please select at least one community"

  Scenario: Edit form validations
    Given I am on the "Home Page"
    And I have created a user account
    When I go to the "Login Page"
    Then I fill in my login details
    Then I should see "Dashboard"
    And I go to the "Create Project Page"
    And I fill in my project details
    And I click on the "submit_button" button
    Then the project info should be shown
    And I click on the "edit_button" link
    Then I should see the edit details
    And I blank the edit fields
    And the project should not be saved

  Scenario: Viewing a project that user has not created
    Given I am on the "Home Page"
    And I have created a user account
    When I go to the "Login Page"
    Then I fill in my login details
    Then I should see "Dashboard"
    When I go to the "newest project"
    Then I should see "Fund this"
    Then I should not see "Edit"
    # TODO - test this in a funding.feature file

  Scenario: Viewing project publicly, clicking on signup
    When I go to the "newest project"
    Then I should not see "Fund this"
    And I should not see "Edit"
    And I should see "Sign up to fund this"
    And I click on the "Sign up to fund this" link
    Then I should see "Create an account"

  Scenario: An initiator should not be able to edit a closed project
    Given I am on the "Home Page"
    And I have created a user account
    When I go to the "Login Page"
    Then I fill in my login details
    And I have created a project
    And the project is closed
    And I go to the "newest project"
    Then I should not see "Edit"
    Then I should see "Project Closed"
