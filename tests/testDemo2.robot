
*** Settings ***
Documentation    Suite description
Library          SeleniumLibrary
Library          Collections
Test Setup       Open the Browser
Test Teardown    Close Browser session
Resource         resource.robot

*** Variables ***
${Error_Message_login}    css:.alert-danger
${Shop_page_load}         css:.nav-link
${Card-title}             css:.card-title

*** Test Cases ***
# Validate Unsuccessful login
    #Fill the Login Form    ${user_name}    ${valid_password}
    #Wait Until Element Is located in the page    ${Error_Message_login}
    #VerifyErrorMessage

Validate Cards display in the Shopping Page
    Fill the Login Form                    ${user_name}    ${valid_password}
   # Wait Until Element Is located in the page    ${Shop_page_load}
    Verify Card titles in the shop page
    Select the Card   Blackberry

Select the Form and navigate to Child Window
  Fill the Login Details and Login Form


*** Keywords ***
Fill the Login Form
    [arguments]    ${username}    ${password}
    Input Text        username     ${username}
    Input Password    password     ${password}
    Click Button      signInBtn
     
    #Wait Until Element Is Visible    ${Error_Message_login}

#Wait Until Element Is located in the page
 #   [arguments]    ${element}
 #   Wait Until Element Is Visible    ${element}

VerifyErrorMessage
    ${result}=    Get Text    ${Error_Message_login}
    #Should Be Equal As Strings    ${result}    Incorrect username/password.

    Element Text Should Be    ${Error_Message_login}    Incorrect username/password.
    Close Browser session

Verify Card titles in the shop page
    @{expectedList} =    Create List        iphone X                           Samsung Note 8    Nokia Edge    Blackberry
    Wait Until Element Is Visible     ${Card-title} 
    ${elements} =        Get WebElements    ${Card-title} 
    Log To Console       ${elements}
    @{actualList} =      Create List
    Log To Console       ${actualList}
    FOR    ${element}    IN    @{elements}
        Append To List    ${actualList}      ${element.text}
        Log    ${element.text}
    END
    Lists Should Be Equal    ${expectedList}    ${actualList}

Select the Card   
  [arguments]   ${cardName}
  Wait Until Element Is Visible     ${Card-title}
  ${elements} =  Get WebElements     css:.card-title
    ${index}=   Set Variable    1
     FOR  ${element}  IN      @{elements}
        Exit For Loop If      '${cardName}' == '${element.text}'
        ${index}=  Evaluate   ${index} + 1
     END
  Click Button    xpath:(//*[@class='card-footer'])[${index}]/button

Fill the Login Details and Login Form
    Input Text          id:username     rahulshettyacademy
    Input Password      id:password     learning
    Click Element       css:input[value='user']
    Wait Until Element Is Visible       css:.modal-body
    #Selenium bug as it does not clicks the modal button with one statement
    Click Button        id:okayBtn
    Click Button        id:okayBtn
    Click Button        id:okayBtn
    Wait Until Element Is Not Visible   css:.modal-body
    Select From List By Value       css:select.form-control       teach
    Select Checkbox     terms
    Checkbox Should Be Selected     terms