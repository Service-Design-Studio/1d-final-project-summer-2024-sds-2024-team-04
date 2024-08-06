Feature: Search
  As a Senior Officer
  I want to search for cases using a condition
  So that I can find a specific case

  Scenario: Searching by condition which at least 1 case fufills
  Given I am on the dashboard page with the search bar with an valid condition
  When I choose ID in the dropdown menu
  And I type in the correct ID "1" in the search bar
  Then I should only see cases with the ID "1" 