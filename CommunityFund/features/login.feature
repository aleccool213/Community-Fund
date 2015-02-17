Feature: Log In

  Scenario: Log in as existing user
    Given I am on the "Home Page"
    And I have created a user account
    When I go to the "Login Page"
    Then I should see "Login"
    Then I should see "Username"
    Then I should see "Password"
    Then I should see "Remember Me?"
    Then I fill in my login details
    Then I should see "Dashboard"

  Scenario: Sign up as new user
    Given I am on the "Home Page"
    And a community exists
    When I go to the "Signup Page"
    Then I should see "Username"
    Then I should see "Email"
    Then I should see "Password"
    Then I should see "Password Confirmation"
    Then I should see "Sign up"
    Then I fill in my signup details
    Then the new user should be created
    Then I should see "Welcome! You have signed up successfully."
    Then I should see "Mind if we grab some more information from you?"
    Then I should see "Hometown"
    Then I should see "Example Community"
    Then I click on the first community
    Then I should belong to the selected community
    Then I should see "Communities Updated!"
