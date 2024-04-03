Feature: User Login

  Scenario: User logs in successfully
    Given a user exists with email "user@example.com" and password "password"
    When I visit the login page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I click the "Log in" button
    Then I should see "Signed in successfully."
    And I should be on the home page

  Scenario: User fails to log in with wrong credentials
    Given a user exists with email "user@example.com" and password "password"
    When I visit the login page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "wrongpassword"
    And I click the "Log in" button
    Then I should see "Invalid Email or password."
    And I should be on the login page

  Scenario: User can log in from the root page with valid credentials
    Given a user exists with email "user@example.com" and password "password"
    When I visit the home page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I click the "Log in" button
    Then I should see "Signed in successfully."
    And I should be on the home page

  Scenario: User cannot log in from the root page with invalid credentials
    Given a user exists with email "user@example.com" and password "password"
    When I visit the home page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "wrongpassword"
    And I click the "Log in" button
    Then I should see "Invalid Email or password."
    And I should be on the login page
