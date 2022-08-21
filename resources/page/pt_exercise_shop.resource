*** Settings ***
Library    SeleniumLibrary  WITH NAME  sl

*** Variables ***
${ADD_TO_BASKET_LOC}            xpath: //button/img[@title="Add exercise to basket"]/..
${BASKET_ITEM_COUNT_LOC}        css: .cart-link-container a div
${BASKET_PROGRAM_EDITOR_LOC}    xpath: //div[text()="Program editor"]

*** Keywords ***
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