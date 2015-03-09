Feature: Feedback
  
  Scenario: A project closes and feedback is created for user
    Given a project exists
    And I have created a user account
    And the project has met funding requirements
    When the project closes
    Then the project should have closed successfully
    And the project should have created feedback

  Scenario: A user dismisses feedback from their dashboard
    Given I have created a user account
    And the user has pending feedback
    When I go to the "Login Page"
    And I fill in my login details
    Then I should see "Dashboard"
    And I should see the pending feedback
    # TODO - ajax calls not working - get selenium working and append @javascript tag to this case
    # And the feedback should be dismissed

  Scenario: A user dismisses one of multiple feedback from their dashboard

  Scenario: A user submits feedback from their dashboard
    Given I have created a user account
    And the user has pending feedback
    When I go to the "Login Page"
    And I fill in my login details
    Then I should see "Dashboard"
    And I should see the pending feedback
    # TODO submit feedback

  Scenario: A user submits one of multiple feedback from their dashboard

  Scenario: A user submits feedback from the index page

  Scenario: A user submits one of multiple feedback from their index page