*** Settings ***
Library     SeleniumLibrary  WITH NAME  sl
Resource    ${G_RESOURCES}${/}window_util.resource

*** Variables ***
${LOGIN_PANE_LOC}    css: .menu-icon1
${LOGIN_LOC}         link: Log in

*** Keywords ***
Click Menu Pane
    sl.Wait Until Element Is Visible  ${LOGIN_PANE_LOC}  5s
    sl.Click Element  ${LOGIN_PANE_LOC}

Click Login
    sl.Wait Until Element Is Visible  ${LOGIN_LOC}
    sl.Click Link  ${LOGIN_LOC}

Go To Login Screen Size Independent
    # May appear for small screen size, will skip failure if not
    BuiltIn.Run Keyword And Return Status  pt_main_page.Click Menu Pane
    pt_main_page.Click Login
    window_util.Wait For Swith To New Window