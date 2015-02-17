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
    # TODO - check that project attributes are there

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
    # TODO test out rewards and date validation too

  Scenario: Viewing a project that user has not created

  Scenario: Viewing project publicly, clicking on signup
