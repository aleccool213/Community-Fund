Feature: Communities

  Scenario: A community with comments should be publicly viewable
    Given a community exists
    And the community has posted comments
    When I go to the "Community Page"
    Then I should see "Some arbitrary comment"