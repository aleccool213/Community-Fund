Feature: Profiles
 
  Scenario: Login, view user profile
    Given I am on the "Home Page"
    And I have created a user account
    When I go to the "Login Page"
    Then I fill in my login details
    Then I should see "Dashboard"
    And I go to my profile page
    Then I should see my profile details