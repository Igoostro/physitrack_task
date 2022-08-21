*** Settings ***
Library      SeleniumLibrary  WITH NAME  sl
Variables    ${G_RESOURCES}${/}pt_configuration.py

*** Keywords ***
Set Default Selenium Settings
    sl.Delete All Cookies
    sl.Set Selenium Speed  50ms
    sl.Set Selenium Implicit Wait  10s

Default Chrome Setup
    sl.Open Browser    ${G_LOGIN_PAGE_URL}  ${G_BROWSER}
    setup_util.Set Default Selenium Settings

Default Teardown
    sl.Close All Browsers