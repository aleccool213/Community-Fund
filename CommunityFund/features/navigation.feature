Feature: Navigation

  Scenario: Check navigation as anonymous visitor
	When I am on the "Home Page"
	Then I should see "Sign Up"
	And I should see "Login"

  Scenario: Check navigation as logged in user
	Given I am signed in as a user
	When I am on the "Home Page"
	Then I should see my username
	And I should see "Edit Profile"
	And I should see "Logout"
	And I should not see "Administration"

  Scenario: Check navigation as logged in admin
	Given I am signed in as an admin
	When I am on the "Home Page"
	Then I should see my username
	And I should see "Edit Profile"
	And I should see "Administration"
	And I should see "Logout"
