*** Settings ***
Library    String
Library     Browser
Library     RequestsLibrary
Resource    ${CURDIR}/../../config/env_config.robot
Resource    ${CURDIR}/../../shared/utilities/api_url.utilities.resource
Resource    ${CURDIR}/../register/register_factories.resource


*** Variables ***
${REGISTER_PATH}            register

# LOCATORS
${SIGN_UP_BUTTON_XPATH}     //button[normalize-space(text())="Sign up"]


*** Keywords ***
I Am On The Registration Page
    [Documentation]    ...
    ${sign_up_heading} =    Set Variable    //h1[text()="Sign up"]
    Get Element States    ${sign_up_heading}    contains    visible

I Have Valid And Unique Credentials
    [Documentation]    ...
    ${user} =    Build User
    ${user_credentials} =    Set Variable    ${EMPTY}
    Set Test Variable    ${user_credentials}    ${user}

I Fill In The Registration Form With These Credentials
    [Documentation]    ...
    Fill All Inputs    ${user_credentials}

I Submit The Form
    [Documentation]    ...
    Click    ${SIGN_UP_BUTTON_XPATH}

My Registration Is Successful
    [Documentation]    ...
    Get Url    equal    ${FRONT_BASE_URL}
    Get Element States    //h1[text()="Sign up"]    contains    detached

I Am Authenticated In The Application
    [Documentation]    ...
    Get Element States    //a[@href="/editor"]    contains    visible

An Account Already Exist With A Given Username
    [Documentation]    ...
    ${user} =    Build User    email=existing_username_scenario@invalid.invalid
    Set Test Variable    ${user}    ${user}
    ${payload} =    Create Dictionary    user=${user}
    RequestsLibrary.POST    ${REGISTER_API_ENDPOINT}
    ...    json=${payload}
    ...    expected_status=201

An Account Already Exist With A Given Email
    [Documentation]    ...
    ${user} =    Build User    username=existing_email_scenario
    Set Test Variable    ${user}    ${user}
    ${payload} =    Create Dictionary    user=${user}
    RequestsLibrary.POST    ${REGISTER_API_ENDPOINT}
    ...    json=${payload}
    ...    expected_status=201

An Account Already Exist With A Given Username And Email
    [Documentation]    ...
    ${user} =    Build User 
    Set Test Variable    ${user}    ${user}
    ${payload} =    Create Dictionary    user=${user}
    RequestsLibrary.POST    ${REGISTER_API_ENDPOINT}
    ...    json=${payload}
    ...    expected_status=201

I Fill The Form With This Existing Username And A Non-Existing Email
    [Documentation]    ...
    ${user} =    Build User
    Fill All Inputs    ${user}

I Fill The Form With This Existing Email And A Non-Existing Username
    [Documentation]    ...
    ${user} =    Build User
    Fill All Inputs    ${user}

I Fill The Form With The Same Existing Username And Email
    [Documentation]    ...
    ${user} =    Build User
    Fill All Inputs    ${user}

The Registration Fails
    [Documentation]    ...
    Get Element States    ${SIGN_UP_BUTTON_XPATH}    contains    enabled
    Register Heading Should Be Visible

I See The Error Message "${message}"
    [Documentation]    ...
    ${error_message_locator} =    Get Element    li:text-is('${message}')
    Get Element States    ${error_message_locator}    contains    visible

I See The Following Error Messages
    [Documentation]    ...
    [Arguments]    @{expected_messages}
    ${error_list_locator} =    Get Element    ul.error-messages
    ${expected_text} =    Catenate    SEPARATOR=\n    @{expected_messages}
    Get Text    ${error_list_locator}    equal    ${expected_text}

#############################

Initialize App Context And Open Page
    [Documentation]    ...
    New Browser    browser=chromium    headless=${False}
    New Context    baseURL=${FRONT_BASE_URL}
    New Page

Go To Registration Page
    [Documentation]    ...
    Go To    ${REGISTER_PATH}

Fill All Inputs
    [Documentation]    ...
    [Arguments]    ${user_credentials}
    Fill Text    //input[@placeholder="Username"]    ${user_credentials}[username]
    Fill Text    //input[@placeholder="Email"]    ${user_credentials}[email]
    Fill Text    //input[@placeholder="Password"]    ${user_credentials}[password]

Register Heading Should Be Visible
    [Documentation]    ...
    ${heading} =    Get Element By Role    HEADING    name=Sign up    exact=True
    Get Element States    ${heading}    contains    visible

Delete Account If Exist
    [Documentation]    ...
    TRY
        ${payload} =    Create Dictionary    user=${user}
        ${response} =    RequestsLibrary.POST    ${LOGIN_API_ENDPOINT}
        ...    json=${payload}
        ...    expected_status=200

        ${headers} =    Create Dictionary    Authorization=Token ${response.json()['user']['token']}
        ${random_email} =    Generate Random Email    ${user}[email]
        ${random_username} =    Generate Random Username
        ${updated_user} =    Create Dictionary    email=${random_email}    username=${random_username}
        ${update_payload} =    Create Dictionary    user=${updated_user}
        RequestsLibrary.PUT    ${UPDATE_USER_ENDPOINT}
        ...    json=${update_payload}
        ...    headers=${headers}
        ...    expected_status=200
    EXCEPT
        Should Be Equal As Integers    0    0
    END

Generate Random Email
    [Documentation]    ...
    [Arguments]    ${email}
    ${username}    ${domain} =    Split String    ${email}    @    max_split=1
    ${timestamp} =    Get Time    format=epoch
    ${random_email} =     Set Variable    deleted_${username}${timestamp}@${domain}
    RETURN    ${random_email}

Generate Random Username
    ${timestamp} =    Get Time    format=epoch
    RETURN    deleted_playmaker1710${timestamp}
