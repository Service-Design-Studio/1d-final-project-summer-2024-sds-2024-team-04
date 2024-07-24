Feature: Login
  As a Senior Officer
  I want to inspect cases indivdually
  So that I can check which how well they scored on each criteria

  Scenario: Navigate to case review page
    Given I am on the dashboard page
    When I click the case with ID "1"
    Then I should be on the case review page for case ID "1"
    And I should see "Case ID : 1"
    And I should see "Topic: MediSave"
