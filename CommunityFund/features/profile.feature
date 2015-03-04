Feature: Profiles
 
  Scenario: Login, view user profile
    Given I am on the "Home Page"
    And I have created a user account
    When I go to the "Login Page"
    Then I fill in my login details
    Then I should see "Dashboard"
    When I go to my profile page
    Then I should see my profile details
    
  Scenario: View user profile of invalid user
    When I go to the profile page of "nonexistant_user"
    Then I should not see "nonexistant_user"
    