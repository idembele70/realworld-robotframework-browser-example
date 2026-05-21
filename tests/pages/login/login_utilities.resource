*** Settings ***
Library    Collections
Library     RequestsLibrary
Resource    ${CURDIR}/../../shared/factories/user_factories.resource
Resource    ${CURDIR}/../../shared/utilities/api_url.utilities.resource
Resource    ${CURDIR}/../../shared/variables.resource


*** Keywords ***
Safe Create User From API
    [Documentation]    ...
    TRY
        ${user_credentials} =    Build User    prefix=login
        &{payload} =    Create Dictionary    user=${user_credentials}
        Set Test Variable    ${user}    ${user_credentials}
        Set Test Variable    ${payload}    ${payload}
        ${response} =    POST
        ...    url=${REGISTER_API_ENDPOINT}
        ...    json=${payload}
        ...    verify=${VERIFY}
    EXCEPT    HTTPError: 422*    type=GLOB
        Log    L'utilisateur existe déjà ou le corps de la requête est invalide.
    ELSE
        Log    Erreur serveur veuillez ressayer.
    END

Get User Token
    [Documentation]    ...
    ${payload} =    Create Dictionary    user=${user}
    ${response} =    POST
    ...    url=${LOGIN_API_ENDPOINT}
    ...    json=${payload}
    ...    verify=${VERIFY}
    RETURN    ${response.json()}[user][token]

Delete User If Exists From API
    [Documentation]    ...
    ${token} =    Get User Token
    ${random_email} =    Generate Random Email    ${user}[email]
    ${random_username} =    Generate Random Username
    Set To Dictionary    ${user}    email=${random_email}    username=${random_username}
    &{payload} =    Create Dictionary    user=${user}
    &{headers} =    Create Dictionary    Authorization=Token ${token}
    TRY
        PUT    url=${UPDATE_USER_ENDPOINT}
        ...    json=${payload}
        ...    headers=${headers}
        ...    verify=${VERIFY}
    EXCEPT
        Log    Utilisateur déjà absent
    END
