Feature: Login
  As a Senior Officer
  I want to inspect a case that has been audited by the AI
  So that I can check which how well the officer scored on each criteria

  Scenario: Navigate to completed case review page
    Given I am on the dashboard page
    When I click the case with ID "1"
    Then I should be on the case review page for case ID "1"
    And I should see "Criteria"
    And I should see "Satisfy/Unsatisfy"
