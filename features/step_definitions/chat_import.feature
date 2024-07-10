Feature: Visiting the Import Page

  Background:
    Given I am on the import CSV form

  Scenario: Import a chat transcript
    When I upload a csv file
    Then the CSV file should be accepted
    When I visit the chat transcripts page
    Then I should see the chat transcript details on the chat transcript list

  Scenario: Import an invalid chat transcript CSV file
    When I upload an invalid CSV file
    Then I should see error messages indicating the invalid chat transcripts