*** Settings ***
Library    SeleniumLibrary  WITH NAME  sl

*** Variables ***
${SERVER_CONTINUE_LOC}    name: button

*** Keywords ***
Select Server
    [Arguments]  ${country_locator}
    sl.Wait Until Element Is Visible  ${country_locator}
    sl.Click Element  ${country_locator}

    sl.Wait Until Element Is Visible  ${SERVER_CONTINUE_LOC}
    sl.Click Element  ${SERVER_CONTINUE_LOC}