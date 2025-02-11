*** Settings ***
Resource    variables.robot
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Dialogs
Library    RequestsLibrary
Documentation    This is the documentation of the test case suites.

*** Variables ***
${csv_file_path}    myData.csv
${URL_request_base}    https://www.google.com
${session_name}    MySession
${form_url}    https://formy-project.herokuapp.com/form
${firstName}    John
${lastName}    Doe
${date}    19-11-2024
${description}    This is a test for Formy
${button_text}    Submit
${checkbox_locator}    css:input[type='checkbox']
${years_exp}    2

*** Keywords ***
Do The Usual
    Open Browser    https://www.google.com/    edge
    Input Text    locator=q    text=Python
    Press Keys    None    ENTER
    Close Browser

*** Test Cases ***
URL Test
    [Documentation]    This is a test case documentation.
    Open Browser    https://www.google.com/    edge
    Title Should Be    Google
    Location Should Be    https://www.google.com/
    Close Browser

Search Test
    [Documentation]    This is a test case documentation.
    [Tags]    Regression
    Open Browser    https://www.google.com/    edge
    Input Text    locator=q    text=Python
    Press Keys    None    ENTER
    [Teardown]    Close Browser

Variables Test
    [Documentation]    Launch Google and search for Python
    [Tags]    Regression
    Open Browser    ${my_URL}    edge
    Input Text    locator=q    text=${my_Query}
    Press Keys    None    ENTER
    [Teardown]    Close Browser

Read from csv
    ${csv_data}=    Run    type ${csv_file_path}
    LOG    CSV Data : ${csv_data}
    ${csv_rows}=    Split To Lines    ${csv_data}
    FOR    ${element}    IN    @{csv_rows}
        Log    ${element}
        
    END

Customised Keywords
    Do The Usual

Built-In Keywords with Pauses
    Open Browser    https://www.google.com/    edge
    Input Text    locator=q    text=Python
    Capture Page Screenshot
    Pause Execution
    Press Keys    None    ENTER
    Pause Execution
    Close Browser

Get response from website
    Create Session    ${session_name}    ${URL_request_base}
    ${response}=    GET On Session    ${session_name}    \
    Should Be Equal As Strings    ${response.status_code}    200

Submit Form
    Open Browser    ${form_url}    edge
    Input Text    id:first-name    ${firstName}
    Input Text    id:last-name    ${lastName}
    Input Text    id:job-title    QA Engineer
    Click Element    id:radio-button-2
    Click Element    ${checkbox_locator}
    Select From List By Value    id:select-menu    ${years_exp}
    Input Text    id:datepicker    ${date}
    Click Element    css:a.btn.btn-lg.btn-primary
    Capture Page Screenshot
    Sleep    5s
    [Teardown]    Close Browser