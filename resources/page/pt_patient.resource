*** Settings ***
Library     SeleniumLibrary  WITH NAME  sl
Resource    ${G_RESOURCES}${/}validation_util.resource

*** Variables ***
${PATIENT_PROGRAM_LIST_LOC}    id: select-protocol

*** Keywords ***
Get Program List
    ${values}  sl.Get List Items  ${PATIENT_PROGRAM_LIST_LOC}
    [Return]  ${values}

Check If Program Name Is In The List Of Programs
    [Arguments]  ${program_name}
    ${program_list}  pt_patient.Get Program List
    validation_util.Check If Any String In List Starts With String  ${program_list}  ${program_name}