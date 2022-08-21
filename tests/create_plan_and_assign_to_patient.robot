*** Settings ***
Library     SeleniumLibrary  WITH NAME  sl
Library     String
Resource    ${G_RESOURCES}${/}setup_util.resource
Resource    ${G_RESOURCES}${/}page${/}pt_tour_common.resource
Resource    ${G_RESOURCES}${/}page${/}pt_main_page.resource
Resource    ${G_RESOURCES}${/}page${/}pt_server_select.resource
Resource    ${G_RESOURCES}${/}page${/}pt_login_page.resource
Resource    ${G_RESOURCES}${/}page${/}pt_exercise_shop.resource
Resource    ${G_RESOURCES}${/}page${/}pt_program_editor.resource
Resource    ${G_RESOURCES}${/}page${/}pt_patient.resource

Suite Setup       setup_util.Default Chrome Setup
Suite Teardown    setup_util.Default Teardown

*** Variables ***
${USA_SERVER_LOC}                id: country_us
${BIRD_DOG_EXERCISE_LOC}         xpath: //a[@title='"Bird dog" Core/abdominal stabilization; 01']
${EXPECTED_BASKET_ITEM_COUNT}    ${1}
${ANGELA_PATIENT_LOC}            xpath: //div[text()="Demo-patient, Angela (Rehab for upper cross syndrome)"]
${PROGRAM_FINAL_ANGELA_LOC}      xpath: //a[text()="Angela Demo-patient" and @class="content-link"]

*** Test Cases ***
Create Plan And Assign To Patient
    pt_main_page.Go To Login Screen Size Independent
    pt_server_select.Select Server  ${USA_SERVER_LOC}
    pt_login_page.Back To Demo

    pt_tour_common.Skip Tour
    pt_exercise_shop.Add Exercise To Basket  ${BIRD_DOG_EXERCISE_LOC}
    pt_exercise_shop.Check Basket Item Count  ${EXPECTED_BASKET_ITEM_COUNT}
    pt_exercise_shop.Submit Exercises To Program Editor

    pt_tour_common.Skip Tour
    ${program_name}  pt_program_editor.Get Program Name
    pt_program_editor.Assign Program To Patient  ${ANGELA_PATIENT_LOC}
    pt_program_editor.In Summary Go To Patient  ${PROGRAM_FINAL_ANGELA_LOC}

    pt_tour_common.Skip Tour
    pt_patient.Check If Program Name Is In The List Of Programs  ${program_name}
