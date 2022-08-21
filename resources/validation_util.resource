*** Settings ***
Library    SeleniumLibrary  WITH NAME  sl

*** Keywords ***
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