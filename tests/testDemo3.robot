
*** Settings ***
Documentation     Suite description
Library           SeleniumLibrary
Library           Collections
Library           String
Test Setup        Open the Browser
Test Teardown     Close Browser 
Resource          resource.robot

*** Variables ***
${Error_Message_login}        css:.alert-danger            

*** Test Cases ***
Validate Child Window Functionality
    Select the link of Child Window
    Verify the user is switched to Child Window
    Grab the Email id in the Child Window
    Switch to Parent window and enter the Email

*** Keywords ***
Select the link of Child Window
    Click Element         css:.blinkingText
    Sleep   5
    
Verify the user is switched to Child Window
    Switch Window       NEW
    Element Text Should Be       css:h1     DOCUMENTS REQUEST

Grab the Email id in the Child Window
    Wait Until Element Is Visible       css:.red
    ${text} =   Get Text    css:.red
    @{words}=   Split String    ${text}   at
    #0 ->Please email u
    #1-> mentor@rahulshettyacademy.com with below template to receive response
    ${text_split}=      Get From List       ${words}    1
    # Blank will split on whitespace
    Log To Console     ${text_split}
    @{words_2}=   Split String    ${text_split}
    #0->mentor@rahulshettyacademy.com
    ${email}=      Get From List    ${words_2}    0
    Log To Console   ${email}
    #Important Interview Question
    Set Global Variable         ${email}

Switch to Parent window and enter the Email
    Switch Window       MAIN
    Title Should Be     LoginPage Practise | Rahul Shetty Academy
    Input Text          id:username     ${email}