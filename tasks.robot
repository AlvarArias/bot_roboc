*** Settings ***
Documentation     Insert new lead in LC.
#Library    RPA.Browser
Library    RPA.Browser.Selenium     auto_close=${FALSE}
Library    RPA.HTTP
Library    RPA.Robocorp.Vault
Library    OperatingSystem
# work Items
Library           RPA.Robocorp.WorkItems
Library           Collections
Library    RPA.Dialogs
Library    RPA.Desktop




*** Tasks ***
Login in LC 
    Open the KP website
    Log in
    Go to Student Page
Form values task
    Fill the form 
    #[Teardown]  Log out and close the browser

*** Variables ***
${URL}      %{WEBSITE_URL}

*** Keywords ***

Open the KP website
    Open Available Browser    ${URL} 
Log in
    ${secret}=    Get Secret    credentials
    Set Selenium Timeout        60 seconds
    Wait Until Page Contains Element    password
    Input Text  identification   ${secret}[user]
    Input Password  password  ${secret}[pass] 
    Set Selenium Timeout        60 seconds
    Wait And Click Button  class:btn-success
    Set Selenium Timeout        60 seconds
    Wait Until Page Contains Element    id:student-load
    Click Element   class:fa-user-graduate
    #Wait Until Element Is Enabled    id:617254
    #Execute Javascript    window.scrollTo(1133,1079)  #go down
Go to Student Page
    Set Selenium Timeout        60 seconds
    Wait Until Page Contains Element    id:page-content                 
    Click Button    class:btn-info
    Click Link    xpath://a[contains(text(),'Add Online Student')]
    Set Selenium Timeout        60 seconds
    Wait Until Page Contains Element   id:id_password1

Fill the form
    # Control Room
    #${theusername}=    Get Work Item Variable   username
    #${thename}=    Get Work Item Variable    estname
    #${thelastname}=    Get Work Item Variable     lastname 
    #${theemail}=    Get Work Item Variable    email 
    #${thepass}=    Get Work Item Variable    password
    #${thechildname}=    Get Work Item Variable    childname
    #${thechildlastname}=    Get Work Item Variable    childlastname
    #${theedad}=    Get Work Item Variable    edad
    #${thecity}=    Get Work Item Variable    city
    #${thecountry}=    Get Work Item Variable    country
    
    #Local
    ${payload}=  Get Work Item Payload
    ${theusername}=    Set Variable  ${payload}[username]
    ${thename}=    Set Variable    ${payload}[estname]
    ${thelastname}=    Set Variable    ${payload}[lastname] 
    ${theemail}=    Set Variable       ${payload}[email] 
    ${thepass}=    Set Variable   ${payload}[password]
    ${thechildname}=    Set Variable   ${payload}[childname]
    ${thechildlastname}=    Set Variable   ${payload}[childlastname]
    ${theedad}=    Set Variable   ${payload}[edad]
    ${thecity}=    Set Variable   ${payload}[city]
    ${thecountry}=    Set Variable   ${payload}[country]

    #Fill the user name
    Input Text    id:id_username    ${theusername} 
    #Fill the first name
    Input Text    first_name    ${thechildname} 
    #Fill the last name
    Input Text    last_name    ${thechildlastname}
    #Fill de email
    Input Text    email    ${theemail}
    #Fill Password
    Input Password    password1   ${thepass}
    Input Password    password2   ${thepass}
    #Take screen shoot
    Screenshot    class:panel    ${OUTPUT_DIR}${/}new_student.png
    #Click Save
    Click Element    class:btn-success
    # Second page
    Set Selenium Timeout        60 seconds
    Wait Until Page Contains Element    class:btn-primary 
    #Edit Student
    Click Link   xpath://a[contains(text(),'Edit Student')]
    # Idioma estudiante
    Set Selenium Timeout        60 seconds
    Wait Until Element Is Visible    class:form-group
    Click Element When Visible  class:chosen-choices
    Click Element When Visible  class:chosen-choices
    # Search-choice
    Click Element When Visible   xpath=//div[@id='id_speaks_chosen']/div/ul/li[32]

    # idioma a estudiar
    Set Selenium Timeout        60 seconds
    Wait Until Element Is Visible    class:form-group
    Select From List By Value    id:id_learning    en
    #Nombre del lead
    Input Text When Element Is Visible    id:id_notes    ${thename} ${thelastname}
    #edad de nino
    Input Text When Element Is Visible   id:id_teacher_notes    ${theedad} 
    #ciudad 
    Input Text When Element Is Visible   id:id_city    ${thecity} 
    # pais
    Input Text When Element Is Visible   id:id_postcode    ${thecountry} 
    #Find Element    id:id_country
    #Scroll Element Into View    id:id_postcode
    #Wait Until Element Is Visible   id:id_country
    #Click Element    id:id_country
    #Click Element    id:id_country_chosen
    #Input Text    class:chosen-search-input    ${thecountry} 
    #Click Element    class:active-result

    # Record screen
    Screenshot    class:panel    ${OUTPUT_DIR}${/}new_student2.png
    #Scroll in to the view
    Execute Javascript    window.scrollTo(1133,1079)  #go down
    #Save data
    Set Selenium Timeout        120 seconds
    Wait Until Element Is Visible    class:btn-primary 
    Click Button    class:btn-primary
Log out and close the browser
    Set Selenium Timeout        60 seconds
    Wait Until Element Is Enabled    id:dropdown-user
    Click Element    id:dropdown-user
    Click Element    id:account_logout
    Close Browser
