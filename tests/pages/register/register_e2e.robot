*** Settings ***
Resource        ./register_e2e.resource

Test Setup      Run Keywords    Initialize App Context And Open Page
...                 AND Go To Registration Page
Test Teardown    Delete Account If Exist

Test Tags       auth    e2e    register


*** Test Cases ***
Successful registration with valid credentials
    [Documentation]    ...
    [Tags]    happy    smoke
    Given I Am On The Registration Page
    And I Have Valid And Unique Credentials
    When I Fill In The Registration Form With These Credentials
    And I Submit The Form
    Then My Registration Is Successful
    And I Am Authenticated In The Application

Registration fails with an existing username
    [Documentation]    ...
    [Tags]    negative    fixme_prod
    Given An Account Already Exist With A Given Username
    And I Am On The Registration Page
    When I Fill The Form With This Existing Username And A Non-Existing Email
    And I Submit The Form
    Then The Registration Fails
    And I See The Error Message "username has already been taken"

Registration Fails With An Existing Email
    [Documentation]    ...
    [Tags]    negative    fixme_prod
    Given An Account Already Exist With A Given Email
    And I Am On The Registration Page
    When I Fill The Form With This Existing Email And A Non-Existing Username
    And I Submit The Form
    Then The Registration Fails
    And I See The Error Message "email has already been taken"

Registration Fails With An Existing Username And Email
    [Documentation]    ...
    [Tags]    negative    fixme    wip
    Given An Account Already Exist With A Given Username And Email
    And I Am On The Registration Page
    When I Fill The Form With The Same Existing Username And Email
    And I Submit The Form
    Then The Registration Fails
    And I See The Following Error Messages
    ...    email has already been taken
    ...    username has already been taken
