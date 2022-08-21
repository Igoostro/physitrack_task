*** Settings ***
Library    SeleniumLibrary  WITH NAME  sl

*** Variables ***
${SKIP_TOUR_FRAME_LOC}    xpath: //iframe[@title="Tour"]
${SKIP_TOUR_LOC}          xpath: //button[@title="Quit Tour"]

*** Keywords ***
Skip Tour
    sl.Wait Until Element Is Visible  ${SKIP_TOUR_FRAME_LOC}
    sl.Select Frame  ${SKIP_TOUR_FRAME_LOC}

    sl.Wait Until Element Is Visible  ${SKIP_TOUR_LOC}
    sl.Click Button  ${SKIP_TOUR_LOC}

    sl.Unselect Frame