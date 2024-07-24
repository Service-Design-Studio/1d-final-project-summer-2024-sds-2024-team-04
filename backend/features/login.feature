Feature: Login
  As a Senior Officer
  I want to log in securely
  So that I can access my dashboard and view my agents' profiles

  Scenario: Successful login with valid credentials
    Given a user with email "seniorofficer@example.com" and password "password123" exists
    When I fill in "Email" with "seniorofficer@example.com"
    And I fill in "Password" with "password123"
    And I press "Log in"
    Then I should see "Welcome, Senior Officer"

  Scenario: Unsuccessful login with invalid credentials
    Given a user with email "seniorofficer@example.com" and password "password123" exists
    When I fill in "Email" with "seniorofficer@example.com"
    And I fill in "Password" with "wrongpassword"
    And I press "Log in"
    Then I should see "Invalid Email or password"
