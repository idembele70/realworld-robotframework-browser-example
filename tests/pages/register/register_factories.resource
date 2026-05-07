*** Keywords ***
Build User
    [Documentation]    ...
    [Arguments]    ${username}=playmaker1712
    ...    ${email}=playmaker1712@invalid.invalid
    ...    ${password}=Str0ngP@ssw0rd?!
    ${user} =    Create Dictionary    username=${username}    email=${email}    password=${password}
    RETURN    ${user}
