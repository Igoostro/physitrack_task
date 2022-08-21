*** Settings ***
Library    SeleniumLibrary  WITH NAME  sl

*** Variables ***
${BACK_TO_DEMO_LOC}    class: link-back-to-demo

*** Keywords ***
Back To Demo
    sl.Wait Until Element Is Visible  ${BACK_TO_DEMO_LOC}
    sl.Click Element  ${BACK_TO_DEMO_LOC}