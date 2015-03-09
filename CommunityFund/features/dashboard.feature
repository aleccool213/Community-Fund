Feature: Dashboard

  Scenario: Go to Dashboard nothing available
    Given I have created a user account
    When I login
    And I fill in my login details
    Then I should see "Dashboard"
    Then I should see "Logged in as"
    And I should see my username
    And I should see "Start Project"
    And I should see "Edit Profile"
    And I should not see "Administration"
    And I should see "Logout"
    And I should see "Wanna?"
    And I should see "Are you a robot? Go join communities!"
    And I should see "No projects have yet been funded."
    And I should see "No projects have been started."
    And I should see "No feedbacks are available."

  Scenario: Go to Dashboard, sidebar filled with data
    Given I have created a user account
    Given I am apart of communities
    And the user has pending feedback
    Given I have started projects
    Given I have funded projects
    When I login
    And I fill in my login details
    Then I should see "Dashboard"
    Then I should see "Logged in as"
    And I should see my username
    And I should see "Start Project"
    And I should see "Edit Profile"
    And I should not see "Administration"
    And I should see "Logout"
    And I should see "Browse all communities"
    And I should not see "Are you a robot? Go join communities!"
    And I should not see "No projects yet have been funded."
    And I should not see "No projects have been started."
    And I should not see "No feedbacks are available."

  Scenario: Go to Dashboard, see event panels for communities
    Given I have created a user account
    Given I am apart of communities
    Given those communities have projects
    Given I have funded projects
    When I login
    And I fill in my login details
    Then should appear latest milestone

  Scenario: Go to Dashboard, see event panels for feedbacks
    Given a project exists
    And I have created a user account
    And the project has met funding requirements
    When the project closes
    Then the project should have closed successfully
    And the latest feedback is submitted
    When I login
    And I fill in my login details
    Then should appear latest feedback

  Scenario: Go to Dashboard, see event panels for projects located near them

    
  
