Feature: Search
  As a Senior Officer
  I want to search for cases using a condition
  So that I can find a specific case

  Scenario: Searching by condition which no cases fufill
  Given I am on the dashboard page with the search bar with an invalid condition
  When I choose the ID category in the dropdown menu
  And I type in the wrong ID "10" in the search bar
  Then I should see no cases 