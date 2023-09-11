
*** Settings ***
Documentation    A resource file with reusable keywords and variables
Library          SeleniumLibrary


*** Variables ***
${user_name}           rahulshettyacademy
${invalid_password}    123456
${valid_password}      learning
${url}                 https://rahulshettyacademy.com/loginpagePractise/

*** Keywords ***
Open the Browser
    Create Webdriver    Chrome
    Go To               ${url}

Close Browser session
    Close Browser