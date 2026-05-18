*** Settings ***
Resource        ./register_page.resource

Test Setup      Run Keywords    Initialize App Context And Open Page
...                 AND Go To Registration Page
Test Teardown    Delete Account If Exists

Test Tags       auth    e2e    register


*** Test Cases ***
Successful Registration With Valid Credentials
    [Documentation]    ...
    [Tags]    happy    smoke
    Given I Am On The Registration Page
    And I Have Valid And Unique Credentials
    When I Fill In The Registration Form With These Credentials
    And I Submit The Form
    Then My Registration Is Successful
    And I Am Authenticated In The Application

Registration Fails With An Existing Username
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
    Given An Account Already Exists With A Given Username And Email
    And I Am On The Registration Page
    When I Fill The Form With The Same Existing Username And Email
    And I Submit The Form
    Then The Registration Fails
    And I See The Following Error Messages
    ...    email has already been taken
    ...    username has already been taken

Attempt to register without a username
    [Documentation]    ...
    [Tags]    negative
    Given I Am On The Registration Page
    When I Fill In The Form Leaving The "username" Field Empty
    Then The Submit Button Is Disabled

Attempt to register without an email
    [Documentation]    ...
    Given I Am On The Registration Page
    When I Fill In The Form Leaving The "email" Field Empty
    Then The Submit Button Is Disabled

Attempt to register Without A Password
    [Documentation]    ...
    [Tags]    negative
    Given I Am On The Registration Page
    When I Fill In The Form Leaving The "password" Field Empty
    Then The Submit Button Is Disabled

An Authenticated user cannot access the registration page
    [Documentation]    ...
    [Tags]    negative
    Given I Have Successfully Registered And I Am Authenticated
    When I Try To Access The Registration Page
    Then Access To The Page Is Restricted For Authenticated Users

Registration With A Leading Space In The Username
    [Documentation]    ...
    [Tags]    edge
    Given I Am On The Registration Page
    And I Have Valid Credentials
    When I Fill In The Form With A Leading Space In The Username
    And I Submit The Form
    Then My Registration Is Successful

Registration with A leading space in the email
    [Documentation]    ...
    [Tags]    edge
    Given I Am On The Registration Page
    And I Have Valid Credentials
    When I Fill In The Form With A Leading Space In The Email
    And I Submit The Form
    Then My Registration Is Successful

Registration With A Leading Space In The Password
    [Documentation]    ...
    [Tags]    edge
    Given I Am On The Registration Page
    And I Have Valid Credentials
    When I Fill In The Form With A Leading Space In The Password
    And I Submit The Form
    Then My Registration Is Successful
