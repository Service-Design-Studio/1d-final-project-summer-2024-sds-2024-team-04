Feature: Override
  As a Senior Officer
  I want to override the AI scoring for criteria in a case
  So that I can ensure my officers have accurate results

  Scenario: Override criteria result
    Given I am on the case review page with criteria that I want to override
    When I click the "Override Result" button
    And I choose "Unsatisfy" in the row with "Criteria8"
    And I click the "Submit" button
    Then I should see "Criteria8" with "Unsatisfy"
    And I should see "Edited" under "Audit Result"