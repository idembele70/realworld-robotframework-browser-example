*** Settings ***
Library     String


*** Keywords ***
Build User
    [Documentation]    ...
    [Arguments]    ${prefix}=${EMPTY}
    ...    ${username}=playmaker1712
    ...    ${email}=playmaker1712@invalid.invalid
    ...    ${password}=Str0ngP@ssw0rd?!
    IF    '${prefix}' != '${EMPTY}'
        ${prefix} =    Set Variable    ${prefix}_
    END
    ${user} =    Create Dictionary    username=${prefix}${username}    email=${prefix}${email}    password=${prefix}${password}
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
