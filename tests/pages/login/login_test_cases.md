# Feature: User Login

**Global tags:** `auth` `e2e`

***

## Happy Path Scenarios

### Scenario: Successful login with valid credentials

**Tags:** `e2e` `auth` `happy` `smoke`

```gherkin
Feature: User Login

  e2e auth happy smoke
  Scenario: Successful login with valid credentials
    Given the user navigates to login page
    And the login form is visible
    When the user enters a valid email in the email field
    And the user enters a valid password in the password field
    And the user clicks the login button
    Then the user should be redirected to the homepage
    And the user should see their profile or username displayed
```

### Scenario: Login and redirect back to previous protected page

**Tags:** `e2e` `auth` `happy` `regression`

```gherkin
Feature: User Login

  e2e auth happy regression
  Scenario: Login and redirect back to previous protected page
    Given the user tries to access a protected page
    And the user is redirected to the login page
    When the user enters valid credentials
    And the user clicks the login button
    Then the user should be redirected back to the protected page
    And the protected content should be visible
```

### Scenario: Login with valid credentials using keyboard submission

**Tags:** `e2e` `auth` `happy` `validation`

```gherkin
Feature: User Login

  e2e auth happy validation
  Scenario: Login with valid credentials using keyboard submission
    Given the user navigates to the login page
    And the login form is visible
    When the user enters a valid email and password
    And the user presses the Enter key
    Then the user should be logged in successfully
    And the homepage should be displayed
```

### Scenario: Remember authenticated session after refresh

**Tags:** `e2e` `auth` `happy` `regression`

```gherkin
Feature: User Login

  e2e auth happy regression
  Scenario: Remember authenticated session after refresh
    Given the user logs in with valid credentials
    And the homepage is displayed
    When the user refreshes the browser
    Then the user should remain logged in
    And the user profile should still be visible
```

***

## Negative Scenarios

### Scenario: Login with invalid password

**Tags:** `e2e` `auth` `negative` `validation`

```gherkin
Feature: User Login

  e2e auth negative validation
  Scenario: Login with invalid password
    Given the user navigates to the login page
    When the user enters a valid email
    And the user enters an invalid password
    And the user clicks the login button
    Then an error message should be displayed
    And the user should remain on the login page
```

### Scenario: Login with unregistered email

**Tags:** `e2e` `auth` `negative` `validation`

```gherkin
Feature: User Login

  e2e auth negative validation
  Scenario: Login with unregistered email
    Given the user navigates to the login page
    When the user enters an unregistered email
    And the user enters a password
    And the user clicks the login button
    Then an authentication error should be displayed
    And the user should not be logged in
```

### Scenario: Submit login form with empty fields

**Tags:** `e2e` `auth` `negative` `validation`

```gherkin
Feature: User Login

  e2e auth negative validation
  Scenario: Submit login form with empty fields
    Given the user navigates to the login page
    When the user clicks the login button without entering any data
    Then validation messages should be displayed for required fields
    And the user should remain on the login page
```

### Scenario: Login attempt with SQL injection input

**Tags:** `e2e` `auth` `negative` `security`

```gherkin
Feature: User Login

  e2e auth negative security
  Scenario: Login attempt with SQL injection input
    Given the user navigates to the login page
    When the user enters "' OR 1=1 --" in the email field
    And the user enters "' OR 1=1 --" in the password field
    And the user clicks the login button
    Then the login attempt should be rejected
    And an error message should be displayed
```

***

## Edge Case Scenarios

### Scenario: Login with maximum allowed input length

**Tags:** `e2e` `auth` `edge` `validation`

```gherkin
Feature: User Login

  e2e auth edge validation
  Scenario: Login with maximum allowed input length
    Given the user navigates to the login page
    When the user enters an email with maximum allowed length
    And the user enters a password with maximum allowed length
    And the user clicks the login button
    Then the system should process the request without crashing
    And a valid response should be returned
```

### Scenario: Login with leading and trailing spaces in credentials

**Tags:** `e2e` `auth` `edge` `validation`

```gherkin
Feature: User Login

  e2e auth edge validation
  Scenario: Login with leading and trailing spaces in credentials
    Given the user navigates to the login page
    When the user enters a valid email with leading and trailing spaces
    And the user enters a valid password with leading and trailing spaces
    And the user clicks the login button
    Then the spaces should be trimmed or handled properly
    And the user should be logged in successfully
```
