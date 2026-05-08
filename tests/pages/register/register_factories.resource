*** Settings ***
Library     String


*** Keywords ***
Build User
    [Documentation]    ...
    [Arguments]    ${username}=playmaker1712
    ...    ${email}=playmaker1712@invalid.invalid
    ...    ${password}=Str0ngP@ssw0rd?!
    ${user} =    Create Dictionary    username=${username}    email=${email}    password=${password}
    RETURN    ${user}

Generate Random Email
    [Documentation]    ...
    [Arguments]    ${email}
    ${username}    ${domain} =    Split String    ${email}    @    max_split=1
    ${timestamp} =    Get Time    format=epoch
    ${random_email} =    Set Variable    deleted_${username}${timestamp}@${domain}
    RETURN    ${random_email}

Generate Random Username
    [Documentation]    ...
    ${timestamp} =    Get Time    format=epoch
    RETURN    deleted_playmaker1710${timestamp}
