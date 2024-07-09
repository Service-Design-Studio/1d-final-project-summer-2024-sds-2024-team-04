Feature: Employee Management

  Background:
    Given I am on the new employee form

  Scenario: Create a new employee
    When I fill in the employee details
      | Field         | Value               |
      | First Name    | John                |
      | Last Name     | Doe                 |
      | Email         | john.doe@example.com|
      | Contact Number| 9876543210          |
      | Address       | 123 Main St         |
      | Pincode       | 12345               |
      | City          | Anytown             |
      | State         | AnyState            |
      | Date of Birth | 1990-01-01          |
      | Date of Hiring| 2024-07-08          |
      | Role          | Agent               |
    And I submit the form
    Then I should see the employee details on the employee list
      | Field         | Value               |
      | First Name    | John                |
      | Last Name     | Doe                 |
      | Email         | john.doe@example.com|
      | Contact Number| 9876543210          |
      | Address       | 123 Main St         |
      | Pincode       | 12345               |
      | City          | Anytown             |
      | State         | AnyState            |
      | Date of Birth | 1990-01-01          |
      | Date of Hiring| 2024-07-08          |
      | Role          | Agent               |

  Scenario: Validation errors on new employee form
    When I fill in invalid employee details
      | Field         | Value               |
      | First Name    |                     |
      | Last Name     |                     |
      | Email         | invalid-email.com   |
      | Contact Number| 1234567890          |
      | Address       |                     |
      | Pincode       |                     |
      | City          |                     |
      | State         |                     |
      | Date of Birth | 2024-07-08          |
      | Date of Hiring| 1990-01-01          |
      | Role          |                     |
    And I submit the form
    Then I should see errors for each invalid field
      | Error Message                         |
      | First Name can't be blank             |
      | Last Name can't be blank              |
      | Email is invalid                      |
      | Contact Number is invalid             |
      | Address can't be blank                |
      | Pincode can't be blank                |
      | City can't be blank                   |
      | State can't be blank                  |
      | Date of Birth must be before Date of Hiring |
      | Role can't be blank                   |
