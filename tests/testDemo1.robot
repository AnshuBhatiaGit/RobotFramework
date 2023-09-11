
*** Settings ***
Documentation     Suite description
Library           SeleniumLibrary
Test Teardown     Close Browser 

*** Variables ***
${Error_Message_login}        css:.alert-danger            

*** Test Cases ***
Validate Unsuccessful login
    FirstTest
    Fill the Login
    VerifyErrorMessage

*** Keywords ***
FirstTest
  Create Webdriver    Chrome   
  Go To    https://rahulshettyacademy.com/loginpagePractise/

Fill the Login
  Input Text        username    rahulshettyacademy
  Input Password    password    12345678       
  Click Button      signInBtn
  Wait Until Element Is Visible    ${Error_Message_login}   

VerifyErrorMessage
  ${result}=    Get Text    ${Error_Message_login}   
  #Should Be Equal As Strings    ${result}    Incorrect username/password.     
  
  Element Text Should Be      ${Error_Message_login}      Incorrect username/password.   
  Close Browser
    
