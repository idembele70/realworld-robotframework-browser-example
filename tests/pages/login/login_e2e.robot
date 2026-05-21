*** Settings ***
Resource    ${CURDIR}/login_page.resource
Resource    ${CURDIR}/login_utilities.resource

Test Tags    e2e    auth
Test Setup    Run Keywords    Open App Page
...    AND    Safe Create User From API
Test Teardown    Run Keywords    Delete User If Exists From API
...    AND    Close Browser    CURRENT


*** Test Cases ***
Sucessful Login With Valid Credentials
    [Documentation]    ...
    [Tags]    happy    smoke
    Given The User Navigates To Login Page
    And The Login Form Is Visible
    When The User Enters A Valid Email In The Email Field
    And The User Enters A Valid Password In The Password Field
    And The User Clicks The Login Button
    Then User Should Be Redirected To The Homepage
    And The User Should See Their Profile Or Username Displayed

Login And Redirect Back To Previous Protected Page
    [Documentation]    ...
    [Tags]    happy    regression    fixme
    # User is not redirected to login page.
    # User is not redirected to protected page after logged
    Given The User Tries To Access A Protected Page
    And The User Is Redirected To The Login Page
    When The User Enters Valid Credentials
    And The User Clicks The Login Button
    Then The User Should Be Redirected Back To The Protected Page
    And The Protected Content Should Be Visible

Login with valid credentials using keyboard submission
    [Documentation]    ...
    [Tags]    happy    validation
    Given The User Navigates To Login Page
    And The Login Form Is Visible
    When The User Enters A Valid Email And Password
    And The User Presses The Enter Key
    Then The User Should Be Logged In Successfully
    And The Homepage Should Be Displayed

Remember Authenticated Session After Refresh
    [Documentation]    ...
    [Setup]    Run Keywords    Open App Page
    ...    AND    Safe Create User From API
    ...    AND    Go To Login Page
    Given The User Logs In With Valid Credentials
    And The Homepage Is Displayed
    When The User Refreshes The Browser
    Then The User Should Remain Logged In
    And User Profile Should Still Be Visible

Login with invalid password
    [Documentation]    ...
    [Tags]    negative    validation
    Given The User Navigates To Login Page
    When The User Enters A Valid Email
    And The Users Enter An Invalid Password
    And The User Clicks The Login Button
    Then An Error Message Should Be Displayed
    And The User Remain On The Login Page

Login With Unregistered Email
    [Documentation]    ...
    [Tags]    negative    validation
    Given The User Navigates To Login Page
    When The User Enters And Unregistered Email
    And The User Enters A Password
    And The User Clicks The Login Button
    Then An Authentication Error Should Be Displayed
    And The User Should Not Be Logged In

Submit Login Form With Empty Fields
    [Documentation]    ...
    [Tags]    negative    validation    fixme
    # Le button est desactive quand les champs sont vide
    Given The User Navigates To Login Page
    When The User Clicks The Login Button Without Entering Any Data
    Then Validation Messages Should Be Displayed For Required Fields
    And The User Should Remain On The Login Page

Login attempt with SQL injection input
    [Documentation]    ...
    [Tags]    negative    security    fixme
    # the login is not rejected
    Given The User Navigates To Login Page
    When The User Enters "' OR 1=1 --" In The Email Field
    And The User Enters "' OR 1=1 --" In The Password Field
    And The User Clicks The Login Button
    Then The Login Attempt Should Be Rejected
    And An Error Message Should Be Displayed
