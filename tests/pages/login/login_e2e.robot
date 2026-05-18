*** Settings ***
Library    Browser
Resource    ${CURDIR}/../../shared/variables.resource
Resource    ${CURDIR}/../../config/env_config.robot

Test Setup    No Operation
Test Teardown    No Operation


*** Keywords ***
Open App Page
    [Documentation]    ...
    New Browser    browser=chromium    headless=${HEADLESS}
    New Context    baseURL=${FRONT_BASE_URL}
    New Page
