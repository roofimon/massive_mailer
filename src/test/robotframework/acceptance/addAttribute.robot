*** Settings ***
Library		   Selenium2Library
Resource       resource.robot
Test Setup     Open Browser To View Contract 
Test Teardown  Close Browser
Default Tags   attribute

*** Variables ***
${UPDATED_FIRSTNAME}     ""  

 
*** Testcases ***
Verify Edit Attribute
    [Tags]    work_in_progress
    Given There is a contact    aaa@gmail.com
    And I change the first name   aaa@gmail.com   Terry
    When I view the attributes of    aaa@gmail.com
    Then The first name should be   Terry

***Keywords***	
Open Browser To View Contract
    Open Browser    http://localhost:8080/contactlist.jsp    ${BROWSER}

There Is A Contact    [Arguments]    ${email}
    #Element Should Contain    //*[@id="contactTable"]    aaa@gmail.com
    Element Should Contain    //li[contains(., '${email}')]    ${email}
    

I Change The First Name    [Arguments]    ${email}    ${firstname}
    Click Element    //li[contains(., '${email}')]//following-sibling::li
    Input Text  fistname  ${firstname}
    Click Button    save_button

I View The Attributes Of    [Arguments]    ${email}
    ${UPDATED_FIRSTNAME} =   //li[contains(., '${email}')]//following-sibling::li
    Set Suite Variable    ${UPDATED_FIRSTNAME}   
    
The First Name Should Be    [Arguments]    ${firstname}
    Should Be Equal As Strings    ${UPDATED_FIRSTNAME}    ${firstname}

