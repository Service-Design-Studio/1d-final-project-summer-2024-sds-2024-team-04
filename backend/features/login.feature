Feature: Login
  As a Senior Officer
  I want to log in securely
  So that I can access my dashboard and view my agents' profiles

  Scenario: Successful login with valid credentials
    Given a user with email "myo@gmail.com" and password "012345" exists
    Given I am on the login page
    When I fill in "Username" with "myo@gmail.com"
    And I fill in "Password" with "012345"
    And I press "Login"
    Then I should see a Dashboard

  Scenario: Unsuccessful login with invalid credentials
    Given a user with email "myo@gmail.com" and password "012345" exists
    Given I am on the login page
    When I fill in "Username" with "seniorofficer@example.com"
    And I fill in "Password" with "wrongpassword"
    And I press "Login"
    Then I should see an error message