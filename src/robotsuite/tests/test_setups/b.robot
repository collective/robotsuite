*** Settings ***

Library  OperatingSystem

Suite setup  Increment global variable

*** Test Cases ***

Global variable is 1 unless ROBOTSUITE_FLATTEN is set
    ${one} =  Convert to integer  1
    ${two} =  Convert to integer  2
    ${flatten} =  Get Environment Variable  ROBOTSUITE_FLATTEN  None
    Run keyword if  '${flatten}' != 'true'
    ...  Should be equal  ${GLOBAL}  ${one}
    Run keyword if  '${flatten}' == 'true'
    ...  Should be equal  ${GLOBAL}  ${two}

*** Keywords ***

Increment global variable
    Set global variable  ${GLOBAL}  ${GLOBAL + 1}
