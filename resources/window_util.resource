*** Settings ***
Library    SeleniumLibrary  WITH NAME  sl

*** Keywords ***
Wait For Swith To New Window
    [Arguments]  ${timeout}=5s
    BuiltIn.Wait Until Keyword Succeeds  ${timeout}  500ms  sl.Switch Window  NEW