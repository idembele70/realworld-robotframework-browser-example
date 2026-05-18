```markdown
# Feature: Authentication - Register

**Global tags:** `auth` `e2e`

---

## Happy Path Scenarios

### Scenario: Successful registration with valid credentials

**Tags:** `auth` `e2e` `happy` `smoke`

```gherkin
Feature: User Registration

  auth e2e happy smoke
  Scenario: Successful registration with valid credentials
    Given I am on the registration page
    And I have valid and unique credentials
    When I fill in the registration form with these credentials
    And I submit the form
    Then my registration is successful
    And I am authenticated in the application
```

---

## Negative Scenarios

### Scenario: Registration fails with an existing username

**Tags:** `auth` `e2e` `negative`

```gherkin
Feature: User Registration

  auth e2e negative
  Scenario: Registration fails with an existing username
    Given an account already exists with a given username
    And I am on the registration page
    When I fill in the form with this existing username and a non-existing email
    And I submit the form
    Then the registration fails
    And I see the error message "username has already been taken"
```

### Scenario: Registration fails with an existing email

**Tags:** `auth` `e2e` `negative`

```gherkin
Feature: User Registration

  auth e2e negative
  Scenario: Registration fails with an existing email
    Given an account already exists with a given email
    And I am on the registration page
    When I fill in the form with this existing email and a non-existing username
    And I submit the form
    Then the registration fails
    And I see the error message "email has already been taken"
```

### Scenario: Registration fails with an existing username and email

**Tags:** `auth` `e2e` `negative`

```gherkin
Feature: User Registration

  auth e2e negative
  Scenario: Registration fails with an existing username and email
    Given an account already exists with a given username and email
    And I am on the registration page
    When I fill in the form with the same existing username and email
    And I submit the form
    Then the registration fails
    And I see the following error messages:
      | email has already been taken    |
      | username has already been taken |
```

### Scenario: Attempt to register without a username

**Tags:** `auth` `e2e` `negative`

```gherkin
Feature: User Registration

  auth e2e negative
  Scenario: Attempt to register without a username
    Given I am on the registration page
    When I fill in the form leaving the "username" field empty
    Then the submit button is disabled
```

### Scenario: Attempt to register without an email

**Tags:** `auth` `e2e` `negative`

```gherkin
Feature: User Registration

  auth e2e negative
  Scenario: Attempt to register without an email
    Given I am on the registration page
    When I fill in the form leaving the "email" field empty
    Then the submit button is disabled
```

### Scenario: Attempt to register without a password

**Tags:** `auth` `e2e` `negative`

```gherkin
Feature: User Registration

  auth e2e negative
  Scenario: Attempt to register without a password
    Given I am on the registration page
    When I fill in the form leaving the "password" field empty
    Then the submit button is disabled
```

### Scenario: An authenticated user cannot access the registration page

**Tags:** `auth` `e2e` `negative`

```gherkin
Feature: User Registration

  auth e2e negative
  Scenario: An authenticated user cannot access the registration page
    Given I have successfully registered and I am authenticated
    When I try to access the registration page
    Then access to the page is restricted for authenticated users
```

---

## Edge Case Scenarios

### Scenario: Registration with a leading space in the username

**Tags:** `auth` `e2e` `edge`

```gherkin
Feature: User Registration

  auth e2e edge
  Scenario: Registration with a leading space in the username
    Given I am on the registration page
    And I have valid credentials
    When I fill in the form with a leading space in the username
    And I submit the form
    Then my registration is successful
```

### Scenario: Registration with a leading space in the email

**Tags:** `auth` `e2e` `edge`

```gherkin
Feature: User Registration

  auth e2e edge
  Scenario: Registration with a leading space in the email
    Given I am on the registration page
    And I have valid credentials
    When I fill in the form with a leading space in the email
    And I submit the form
    Then my registration is successful
```

### Scenario: Registration with a leading space in the password

**Tags:** `auth` `e2e` `edge`

```gherkin
Feature: User Registration

  auth e2e edge
  Scenario: Registration with a leading space in the password
    Given I am on the registration page
    And I have valid credentials
    When I fill in the form with a leading space in the password
    And I submit the form
    Then my registration is successful
```
```