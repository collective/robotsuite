*** Settings ***

Library  Selenium2Library  timeout=${SELENIUM_TIMEOUT}
...                        implicit_wait=${SELENIUM_IMPLICIT_WAIT}

Variables  plone/app/testing/interfaces.py

Test Setup  Open test browser
Test Teardown  Close all browsers

*** Variables ***

${ZOPE_HOST}  localhost
${ZOPE_PORT}  55001
${ZOPE_URL}  http://${ZOPE_HOST}:${ZOPE_PORT}

${PLONE_SITE_ID}  plone
${PLONE_URL}  ${ZOPE_URL}/${PLONE_SITE_ID}

${START_URL}  ${PLONE_URL}

${SELENIUM_IMPLICIT_WAIT}  0.5
${SELENIUM_TIMEOUT}  30

${BROWSER}  Firefox
${REMOTE_URL}
${FF_PROFILE_DIR}
${DESIRED_CAPABILITIES}

*** Test Cases ***

Test Plone login
    [Tags]  login
    Log in  ${TEST_USER_NAME}  ${TEST_USER_PASSWORD}
    Page should contain element  css=#user-name

*** Keywords ***

Open test browser
    Open browser  ${START_URL}  ${BROWSER}
    ...           remote_url=${REMOTE_URL}
    ...           desired_capabilities=${DESIRED_CAPABILITIES}
    ...           ff_profile_dir=${FF_PROFILE_DIR}

Log in
    [Documentation]  Log in to the site as ${userid} using ${password}. There
    ...              is no guarantee of where in the site you are once this is
    ...              done. (You are responsible for knowing where you are and
    ...              where you want to be)
    [Arguments]  ${userid}  ${password}
    Go to  ${PLONE_URL}/login_form
    Page should contain element  __ac_name
    Page should contain element  __ac_password
    Page should contain button  Log in
    Input text for sure  __ac_name  ${userid}
    Input text for sure  __ac_password  ${password}
    Click Button  Log in

Input text for sure
    [Documentation]  Locate input element by ${locator} and enter the given
    ...              ${text}. Validate that the text has been entered.
    ...              Retry until the set Selenium timeout. (The purpose of
    ...              this keyword is to fix random input issues on slow test
    ...              machines.)
    [Arguments]  ${locator}  ${text}
    ${TIMEOUT} =  Get Selenium timeout
    ${IMPLICIT_WAIT} =  Get Selenium implicit wait
    Wait until keyword succeeds  ${TIMEOUT}  ${IMPLICIT_WAIT}
    ...                          Input text and validate  ${locator}  ${text}

Input text and validate
    [Documentation]  Locate input element by ${locator} and enter the given
    ...              ${text}. Validate that the text has been entered.
    [Arguments]  ${locator}  ${text}
    Focus  ${locator}
    Input text  ${locator}  ${text}
    ${value} =  Get value  ${locator}
    Should be equal  ${text}  ${value}
