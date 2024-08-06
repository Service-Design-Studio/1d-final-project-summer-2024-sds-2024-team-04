Feature: Search
  As a Senior Officer
  I want to see an overview of all cases under officers under me
  So that I can assess my team's performance at a glance

  Scenario: See overview of the team's performance
    Given I am on the dashboard for all officers under my team
    Then I should see the "Total Cases", "Total Audited Cases" and "Average Score" text in the dashboard