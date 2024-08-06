Feature: Login
  As a Senior Officer
  I want to inspect a case that has been audited by the AI
  So that I can check which how well the officer scored on each criteria

  Scenario: Navigate to incomplete case review page
    Given I am on the dashboard page with an incomplete case
    When I click the case with status "In Progress"
    Then I should be on the case review page for the incomplete case
    And I should see the line "No audited result!"
