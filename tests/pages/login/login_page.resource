*** Settings ***
Library     Collections
Library     Browser    timeout=%{TIMEOUT=30s}
Resource    ${CURDIR}/../../config/env_config.robot


*** Variables ***
${LOGIN_PATH}                   login
${PROTECTED_PAGE_PATH}          settings

${SIGN_IN_FORM_SELECTOR}        //form[//button[normalize-space()="Sign in"]]
${YOUR_FEED_LINK_SELECTOR}      //a[normalize-space()="Your Feed"]
${EMAIL_SELECTOR}               //input[@placeholder="Email"]
${PASSWORD_SELECTOR}            //input[@placeholder="Password"]
${ERROR_MESSAGE_SELECTOR}       ul.error-messages
${SIGN_IN_BUTTON_SELECTOR}      //button[normalize-space()="Sign in"]


*** Keywords ***
The User Navigates To Login Page
    [Documentation]    ...
    Go To Login Page

The Login Form Is Visible
    [Documentation]    ...
    Login Form Should Be Visible

The User Enters A Valid Email
    [Documentation]    ...
    Fill Email    ${user}[email]

The User Enters A Valid Email In The Email Field
    [Documentation]    ...
    Fill Email    ${user}[email]

The User Enters And Unregistered Email
    [Documentation]    ...
    Set To Dictionary    ${user}    wrong_email=unexisting_email_1710@invalid.invalid
    Fill Email    ${user}[wrong_email]

The User Enters A Valid Password In The Password Field
    [Documentation]    ...
    Fill Password    ${user}[password]

The Users Enter An Invalid Password
    [Documentation]    ...
    Set To Dictionary    ${user}    wrong_password=WR0NG_P@ssw0rd123!:
    Fill Password    ${user}[wrong_password]

The User Enters A Password
    [Documentation]    ...
    Fill Password    ${user}[password]

The User Clicks The Login Button
    [Documentation]    ...
    Submit Form

The User Clicks The Login Button Without Entering Any Data
    Submit Form    ${True}

User Should Be Redirected To The Homepage
    [Documentation]    ...
    Wait For Sign In Form To Be Detached
    Current Url Should Be Homepage's

The User Should See Their Profile Or Username Displayed
    [Documentation]    ...
    ${username} =    Set Variable    ${user}[username]
    ${profile_link} =    Get Element    a[href$='/profile/${username}']
    Get Element States    ${profile_link}    contains    visible
    Get Text    ${profile_link}    equal    ${username}

The User Tries To Access A Protected Page
    [Documentation]    ...
    Go To    ${PROTECTED_PAGE_PATH}

The User Is Redirected To The Login Page
    [Documentation]    ...
    Wait For Elements State    ${SIGN_IN_FORM_SELECTOR}    visible
    Get Url    should end with    ${LOGIN_PATH}

The User Enters Valid Credentials
    [Documentation]    ...
    Fill Email    ${user}[email]
    Fill Password    ${user}[password]

The User Should Be Redirected Back To The Protected Page
    [Documentation]    ...
    Wait For Navigation    url=${FRONT_BASE_URL}${PROTECTED_PAGE_PATH}

The Protected Content Should Be Visible
    [Documentation]    ...
    Get Text    h1    equal    Your Settings

The User Enters A Valid Email And Password
    [Documentation]    ...
    Fill Email    ${user}[email]
    Fill Password    ${user}[password]

The User Presses The Enter Key
    [Documentation]    ...
    Keyboard Key    press    Enter

The User Should Be Logged In Successfully
    [Documentation]    ...
    Wait For Sign In Form To Be Detached
    ${new_article_link} =    Get Element By Role    LINK    name=New Article
    Get Element States    ${new_article_link}    contains    visible

The Homepage Should Be Displayed
    [Documentation]    ...
    Current Url Should Be Homepage's
    Homepage Main Links Should Be Visible

    Get Element States    ${YOUR_FEED_LINK_SELECTOR}    contains    visible
    Get Element States    text=/\s*Global Feed\s*/    contains    visible
    Get Element States    //p[text()="Popular Tags"]    contains    visible

The User Logs In With Valid Credentials
    [Documentation]    ...
    Fill Email    ${user}[email]
    Fill Password    ${user}[password]
    Submit Form
    Wait For Sign In Form To Be Detached
    Current Url Should Be Homepage's

The Homepage Is Displayed
    [Documentation]    ...
    Current Url Should Be Homepage's
    Get Element States    //a[contains(@href, "/settings") and contains(text(), "Settings")]    contains    visible

The User Refreshes The Browser
    [Documentation]    ...
    Reload

The User Should Remain Logged In
    [Documentation]    ...
    Your Feed Link Should Be Visible

User Profile Should Still Be Visible
    [Documentation]    ...
    Get Element States    //a[contains(@href,'/profile/${user}[username]')]    contains    visible

An Error Message Should Be Displayed
    [Documentation]    ...
    Wrong Email Or Password Error Message

An Authentication Error Should Be Displayed
    [Documentation]    ...
    Wrong Email Or Password Error Message

Validation Messages Should Be Displayed For Required Fields
    [Documentation]    ...
    Get Text    ${ERROR_MESSAGE_SELECTOR}    equal    email can't be blank

The User Remain On The Login Page
    [Documentation]    ...
    Login Form Should Be Visible
    Get Text    ${EMAIL_SELECTOR}    ==    ${user}[email]
    Get Text    ${PASSWORD_SELECTOR}    ==    ${user}[wrong_password]

The User Should Not Be Logged In
    [Documentation]    ...
    Login Form Should Be Visible
    Get Element States    //a[@routerlink="/settings" and contains(text(),"Settings")]    contains    detached

The User Should Remain On The Login Page
    [Documentation]    ...
    Login Form Should Be Visible
    Get Element States    ${SIGN_IN_BUTTON_SELECTOR}    contains    visible    disabled

The User Enters "${malicious_email}" In The Email Field
    [Documentation]    ...
    Fill Email    ${malicious_email}

The User Enters "${malicious_password}" In The Password Field
    [Documentation]    ...
    Fill Password    ${malicious_password}

The Login Attempt Should Be Rejected
    [Documentation]    ...
    Get Element States    ${SIGN_IN_BUTTON_SELECTOR}    contains    visible    enabled
    Login Form Should Be Visible

# ACTIONS

Open App Page
    [Documentation]    ...
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    baseURL=${FRONT_BASE_URL}    ignoreHTTPSErrors=${IGNORE_HTTPS_ERRORS}
    New Page

Go To Login Page
    [Documentation]    ...
    Go To    ${LOGIN_PATH}

Fill Email
    [Documentation]    ...
    [Arguments]    ${email}
    Fill Text    ${EMAIL_SELECTOR}    ${email}

Fill Password
    [Documentation]    ...
    [Arguments]    ${password}
    Fill Text    ${PASSWORD_SELECTOR}    ${password}

Wait For Sign In Form To Be Detached
    [Documentation]    ...
    Wait For Elements State    ${SIGN_IN_FORM_SELECTOR}    detached

Current Url Should Be Homepage's
    [Documentation]    ...
    Get Url    equals    ${FRONT_BASE_URL}

Submit Form
    [Documentation]    ...
    [Arguments]    ${force}=${False}
    Click With Options   ${SIGN_IN_BUTTON_SELECTOR}    force=${force}

Your Feed Link Should Be Visible
    [Documentation]    ...
    Get Element States    ${YOUR_FEED_LINK_SELECTOR}    contains    visible

Homepage Main Links Should Be Visible
    [Documentation]    ...
    Your Feed Link Should Be Visible
    Get Element States    text=/\s*Global Feed\s*/    contains    visible
    Get Element States    //p[text()="Popular Tags"]    contains    visible

Wrong Email Or Password Error Message
    [Documentation]    ...
    Get Text    ${ERROR_MESSAGE_SELECTOR}    equal    email or password is invalid

Login Form Should Be Visible
    [Documentation]    ...
    Get Element States    ${SIGN_IN_FORM_SELECTOR}    contains    visible
