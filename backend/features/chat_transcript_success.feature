Feature: Chat Transcript
  As a Senior Officer
  I want to inspect the chat transcript for a case
  So that I can check how accurately the AI scored the case

  Scenario: Navigate to case review page
    Given I am on the dashboard page with a case that has a chat transcript
    When I click the case with ID "1" that has a chat transcript
    Then I should be on the case review page for case ID "1" that has a chat transcript
    And I should see the name "Officer"
    And I should see another name that is not "Officer"
