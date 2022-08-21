*** Settings ***
Library    SeleniumLibrary  WITH NAME  sl

*** Variables ***
${PROGRAM_NAME_LOC}            xpath: //a[@title="Edit program"]
${ASSIGN_PROGRAM_LOC}          xpath: //a[@title="Assign program to patient"]
${PATIENT_LIST_LOC}            xpath: //div[contains(@class, "patient-selector")]
${ASSIGN_PROGRAM_FINAL_LOC}    xpath: //button/span[text()="Assign program"]/..

*** Keywords ***
Get Program Name
    sl.Wait Until Element Is Visible  ${PROGRAM_NAME_LOC}
    ${program_name}  sl.Get Text  ${PROGRAM_NAME_LOC}

    ${ending_space_and_edit_sign_to_remove_count}  BuiltIn.SetVariable  ${2}
    ${program_name}  String.Get Substring  ${program_name}  ${0}  -${ending_space_and_edit_sign_to_remove_count}
    [Return]  ${program_name}

Assign Program To Patient
    [Arguments]  ${patient_locator}
    sl.Wait Until Element Is Visible  ${ASSIGN_PROGRAM_LOC}
    sl.Click Link  ${ASSIGN_PROGRAM_LOC}

    sl.Wait Until Element Is Visible  ${PATIENT_LIST_LOC}
    sl.Click Element  ${PATIENT_LIST_LOC}

    sl.Wait Until Element Is Visible  ${patient_locator}
    sl.Click Element  ${patient_locator}

    sl.Wait Until Element Is Visible  ${ASSIGN_PROGRAM_FINAL_LOC}
    sl.Click Button  ${ASSIGN_PROGRAM_FINAL_LOC}

In Summary Go To Patient
    [Arguments]  ${patient_locator}
    sl.Wait Until Element Is Visible  ${patient_locator}
    sl.Click Link  ${patient_locator}