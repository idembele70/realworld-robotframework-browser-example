*** Settings ***
Library     String
Library     Browser    timeout=30s
Library     RequestsLibrary
Resource    ${CURDIR}/../../config/env_config.robot
Resource    ${CURDIR}/../../shared/utilities/api_url.utilities.resource
Resource    ${CURDIR}/../../shared/factories/user_factories.resource
Resource    ${CURDIR}/../../shared/variables.resource


*** Variables ***
${REGISTER_PATH}            register

# LOCATORS
${SIGN_UP_BUTTON_XPATH}     //button[normalize-space(text())="Sign up"]
${SIGN_UP_HEADING_XPATH}    //h1[text()="Sign up"]


*** Keywords ***
I Am On The Registration Page
    [Documentation]    ...
    Get Element States    ${SIGN_UP_HEADING_XPATH}    contains    visible

I Have Valid And Unique Credentials
    [Documentation]    ...
    ${user} =    Build User    prefix=register
    Set Test Variable    ${user}    ${user}

I Fill In The Registration Form With These Credentials
    [Documentation]    ...
    Fill All Inputs    ${user}

I Submit The Form
    [Documentation]    ...
    Click Submit Button

My Registration Is Successful
    [Documentation]    ...
    Wait For Elements State    //h1[text()="Sign up"]    detached
    Get Url    equal    ${FRONT_BASE_URL}

I Am Authenticated In The Application
    [Documentation]    ...
    Get Element States    //a[@routerlink="/editor"]    contains    visible

An Account Already Exist With A Given Username
    [Documentation]    ...
    ${user} =    Build User    prefix=register    email=existing_username_scenario@invalid.invalid
    Set Test Variable    ${user}    ${user}
    ${payload} =    Create Dictionary    user=${user}
    RequestsLibrary.POST    ${REGISTER_API_ENDPOINT}
    ...    json=${payload}
    ...    expected_status=201
    ...    verify=${VERIFY}

An Account Already Exist With A Given Email
    [Documentation]    ...
    ${user} =    Build User    prefix=register    username=existing_email_scenario
    Set Test Variable    ${user}    ${user}
    ${payload} =    Create Dictionary    user=${user}
    RequestsLibrary.POST    ${REGISTER_API_ENDPOINT}
    ...    json=${payload}
    ...    expected_status=201
    ...    verify=${VERIFY}

An Account Already Exists With A Given Username And Email
    [Documentation]    ...
    ${user} =    Build User    prefix=register
    Set Test Variable    ${user}    ${user}
    ${payload} =    Create Dictionary    user=${user}
    RequestsLibrary.POST    ${REGISTER_API_ENDPOINT}
    ...    json=${payload}
    ...    expected_status=201

I Fill The Form With This Existing Username And A Non-Existing Email
    [Documentation]    ...
    ${user} =    Build User    prefix=register
    Fill All Inputs    ${user}

I Fill The Form With This Existing Email And A Non-Existing Username
    [Documentation]    ...
    ${user} =    Build User    prefix=register
    Fill All Inputs    ${user}

I Fill The Form With The Same Existing Username And Email
    [Documentation]    ...
    ${user} =    Build User    prefix=register
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

I Fill In The Form Leaving The "${field_name}" Field Empty
    [Documentation]    ...
    ${user} =    Build User    prefix=register
    FOR    ${key}    ${value}    IN    &{user}
        IF    '${key}' != '${field_name}'
            ${placeholder_name} =    Convert To Title Case    ${key}
            Fill Text    //input[@placeholder='${placeholder_name}']    ${user}[${field_name}]
        END
    END

The Submit Button Is Disabled
    [Documentation]    ...
    Get Element States    ${SIGN_UP_BUTTON_XPATH}    contains    disabled

I Have Successfully Registered And I Am Authenticated
    [Documentation]    ...
    ${user} =    Build User    prefix=register
    Set Test Variable    ${user}    ${user}
    Fill All Inputs    ${user}
    Click Submit Button
    Wait For Elements State    ${SIGN_UP_HEADING_XPATH}    detached

I Try To Access The Registration Page
    [Documentation]    ...
    Go To    ${REGISTER_PATH}

Access To The Page Is Restricted For Authenticated Users
    [Documentation]    ...
    Wait For Elements State    ${SIGN_UP_HEADING_XPATH}    detached
    Get Url    equal    ${FRONT_BASE_URL}

#############################

Initialize App Context And Open Page
    [Documentation]    ...
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    baseURL=${FRONT_BASE_URL}    ignoreHTTPSErrors=${IGNORE_HTTPS_ERRORS}
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

Click Submit Button
    [Documentation]    ...
    Click    ${SIGN_UP_BUTTON_XPATH}

Register Heading Should Be Visible
    [Documentation]    ...
    ${heading} =    Get Element By Role    HEADING    name=Sign up    exact=True
    Get Element States    ${heading}    contains    visible

Delete Account If Exists
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
    EXCEPT    *    type=GLOB    AS    ${error}
        Log    Account does not exist or user variable missing, skipping cleanup: ${error}
    END
