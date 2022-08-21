*** Settings ***
Library         SeleniumLibrary  WITH NAME  sl
Library         String
Variables       ${G_RESOURCES}${/}pt_configuration.py

Suite Setup     sl.Open Browser    ${G_LOGIN_PAGE_URL}  ${G_BROWSER}
Suite Teardown  sl.Close All Browsers


*** Variables ***
${LOGIN_PANE_LOC}               css: .menu-icon1
${LOGIN_LOC}                    link: Log in
${USA_SERVER_LOC}               id: country_us
${SERVER_CONTINUE_LOC}          name: button
${BACK_TO_DEMO_LOC}             class: link-back-to-demo
${SKIP_TOUR_LOC}                xpath: //button[@title="Quit Tour"]
${SKIP_TOUR_FRAME_LOC}          xpath: //iframe[@title="Tour"]
${BIRD_DOG_EXERCISE_LOC}        xpath: //a[@title='"Bird dog" Core/abdominal stabilization; 01']
${ADD_TO_BASKET_LOC}            xpath: //button/img[@title="Add exercise to basket"]/..
${BASKET_ITEM_COUNT_LOC}        css: .cart-link-container a div
${BASKET_PROGRAM_EDITOR_LOC}    xpath: //div[text()="Program editor"]
${PROGRAM_NAME_LOC}             xpath: //a[@title="Edit program"]
${ASSIGN_PROGRAM_LOC}           xpath: //a[@title="Assign program to patient"]
${PATIENT_LIST_LOC}             xpath: //div[contains(@class, "patient-selector")]
${ANGELA_PATIENT_LOC}           xpath: //div[text()="Demo-patient, Angela (Rehab for upper cross syndrome)"]
${ASSIGN_PROGRAM_FINAL_LOC}     xpath: //button/span[text()="Assign program"]/..
${PROGRAM_FINAL_ANGELA_LOC}     xpath: //a[text()="Angela Demo-patient" and @class="content-link"]
${PATIENT_PROGRAM_LIST_LOC}     id: select-protocol

*** Keywords ***
Click Menu Pane
    sl.Wait Until Element Is Visible  ${LOGIN_PANE_LOC}  5s
    sl.Click Element  ${LOGIN_PANE_LOC}

Click Login
    sl.Wait Until Element Is Visible  ${LOGIN_LOC}
    sl.Click Link  ${LOGIN_LOC}

Wait For Swith To New Window
    [Arguments]  ${timeout}=5s
    BuiltIn.Wait Until Keyword Succeeds  ${timeout}  500ms  sl.Switch Window  NEW

Login Screen Size Independent
    # May appear for small screen size, will skip failure if not
    Run Keyword And Return Status  Click Menu Pane
    Click Login
    Wait For Swith To New Window

Select Server
    [Arguments]  ${country_locator}
    sl.Wait Until Element Is Visible  ${country_locator}
    sl.Click Element  ${country_locator}

    sl.Wait Until Element Is Visible  ${SERVER_CONTINUE_LOC}
    sl.Click Element  ${SERVER_CONTINUE_LOC}

Back To Demo
    sl.Wait Until Element Is Visible  ${BACK_TO_DEMO_LOC}
    sl.Click Element  ${BACK_TO_DEMO_LOC}

#####

Skip Tour
    sl.Wait Until Element Is Visible  ${SKIP_TOUR_FRAME_LOC}
    sl.Select Frame  ${SKIP_TOUR_FRAME_LOC}

    sl.Wait Until Element Is Visible  ${SKIP_TOUR_LOC}
    sl.Click Button  ${SKIP_TOUR_LOC}

    sl.Unselect Frame

Add Exercise To Basket
    [Arguments]  ${exercise_locator}
    sl.Wait Until Element Is Visible  ${exercise_locator}
    sl.Click Link  ${exercise_locator}

    sl.Wait Until Element Is Visible  ${ADD_TO_BASKET_LOC}
    sl.Click Button  ${ADD_TO_BASKET_LOC}

Check Basket Item Count
    [Arguments]  ${expected_count}
    sl.Wait Until Element Is Visible  ${BASKET_ITEM_COUNT_LOC}
    sl.Wait Until Element Contains  ${BASKET_ITEM_COUNT_LOC}  ${expected_count}

Submit Exercises To Program Editor
    sl.Wait Until Element Is Visible  ${BASKET_ITEM_COUNT_LOC}
    sl.Mouse Over  ${BASKET_ITEM_COUNT_LOC}

    sl.Wait Until Element Is Visible  ${BASKET_PROGRAM_EDITOR_LOC}
    sl.Click Link  ${BASKET_PROGRAM_EDITOR_LOC}/..

###

Program Editor Get Program Name
    sl.Wait Until Element Is Visible  ${PROGRAM_NAME_LOC}
    ${program_name}  sl.Get Text  ${PROGRAM_NAME_LOC}

    ${ending_space_and_edit_sign_to_remove_count}  BuiltIn.SetVariable  ${2}
    ${program_name}  String.Get Substring  ${program_name}  ${0}  -${ending_space_and_edit_sign_to_remove_count}
    [Return]  ${program_name}

Program Editor Assign To Patient
    [Arguments]  ${patient_locator}
    sl.Wait Until Element Is Visible  ${ASSIGN_PROGRAM_LOC}
    sl.Click Link  ${ASSIGN_PROGRAM_LOC}

    sl.Wait Until Element Is Visible  ${PATIENT_LIST_LOC}
    sl.Click Element  ${PATIENT_LIST_LOC}

    sl.Wait Until Element Is Visible  ${patient_locator}
    sl.Click Element  ${patient_locator}

    sl.Wait Until Element Is Visible  ${ASSIGN_PROGRAM_FINAL_LOC}
    sl.Click Button  ${ASSIGN_PROGRAM_FINAL_LOC}

Program Editor Summary Go To Patient
    [Arguments]  ${patient_locator}
    sl.Wait Until Element Is Visible  ${patient_locator}
    sl.Click Link  ${patient_locator}

###

Patient Get Program List
    ${values}  Get List Items  ${PATIENT_PROGRAM_LIST_LOC}
    [Return]  ${values}
###

Patient Check If Program Name Is In The List Of Programs
    [Arguments]  ${program_name}
    ${program_list}  Patient Get Program List
    Check If Any String In List Starts With String  ${program_list}  ${program_name}

Check If Any String In List Starts With String
    [Arguments]  ${string_list}  ${expected_leading_str}
    FOR  ${entry}  IN  @{string_list}
        ${status}  BuiltIn.Run Keyword And Return Status
        ...  BuiltIn.Should Start With  ${entry}  ${expected_leading_str}
        IF  ${status} == ${TRUE}
            BuiltIn.Return From Keyword
        END
    END
    BuiltIn.Fail  ${expected_leading_str} is not starting any list entry. List: ${string_list}

*** Test Cases ***
Create Plan And Assign To Patient
    sl.Delete All Cookies
    sl.Set Selenium Speed  50ms
    sl.Set Selenium Implicit Wait  10s

    Login Screen Size Independent
    Select Server  ${USA_SERVER_LOC}
    Back To Demo

    Skip Tour
    Add Exercise To Basket  ${BIRD_DOG_EXERCISE_LOC}
    sl.Capture Page Screenshot
    Check Basket Item Count  ${1}
    Submit Exercises To Program Editor

    Skip Tour
    ${program_name}  Program Editor Get Program Name
    Program Editor Assign To Patient  ${ANGELA_PATIENT_LOC}
    Program Editor Summary Go To Patient  ${PROGRAM_FINAL_ANGELA_LOC}

    Skip Tour
    Patient Check If Program Name Is In The List Of Programs  ${program_name}
