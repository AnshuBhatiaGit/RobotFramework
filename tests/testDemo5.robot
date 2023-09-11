
*** Settings ***
Documentation     Suite description
Library           SeleniumLibrary
Library           DataDriver    file=resources/data.csv   encoding=utf_8    dialect=unix
Test Teardown     Close Browser
Test Template     Validate Unsuccessful login

*** Variables ***
${Error_Message_login}        css:.alert-danger            

*** Test Cases ***    username    password
Login with user  ${username} and password ${password}   xyc     123456


*** Keywords ***
Validate Unsuccessful login
  [arguments]   ${username}   ${password}
  Open the browser
  Fill the Login  ${username}      ${password}
  wait until it checks and display error message
  VerifyErrorMessage

Open the browser
  Create Webdriver    Chrome   
  Go To    https://rahulshettyacademy.com/loginpagePractise/

Fill the Login
  [arguments]     ${username}       ${password}
  Input Text        id:username     ${username}
  Input Password    id:password     ${password}     
  Click Button      signInBtn
 
wait until it checks and display error message
    Wait Until Element Is Visible       ${Error_Message_Login}

VerifyErrorMessage
  ${result}=    Get Text    ${Error_Message_login}   
  Should Be Equal As Strings    ${result}    Incorrect username/password.     
  Element Text Should Be      ${Error_Message_login}      Incorrect username/password.   

  Close Browser
    
