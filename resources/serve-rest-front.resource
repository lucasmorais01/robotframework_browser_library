*** Settings ***
Library    Browser        enable_presenter_mode=${False}
Library    FakerLibrary
Library    DateTime


*** Variables ***
${BROWSER}             chromium
${HEADLESS}            ${False}
${URL_SERVE_REST}      https://front.serverest.dev/login

*** Keywords ***
Abrir o Navegador
         New Browser        browser=${BROWSER}
         ...                headless=${HEADLESS}
         

   # ${TRACE_NAME}               FakerLibrary.Uuid 4
   # ${NOW}                      Get Current Date    result_format=%d-%m-%Y_%H%M%S       
   #   ...                tracing==${OUTPUT_DIR}/evidencies/traces/{NOW}/${TRACE_NAME}.zip
   #  ...                recordVideo={'dir':'${OUTPUT_DIR}'}/evidencies/videos/${NOW}}

         New Context         viewport={'width': 1200, 'height': 800}     
Ir para o site
        New Page              url=${URL_SERVE_REST}   
        ${title}              Get Title  ==   Front - ServeRest   #espaço duplo na condição
        Log    ${title}

Cadastrar novo usuario      
       ### Record Selector 
        Click                css=.btn-link
        ${EMAIL}             FakerLibrary.Email
        Set Test Variable     ${EMAIL}
        Fill Text            css=input[data-testid='nome']   Lucas GSM
        Fill Text            css=input[data-testid='email']   ${EMAIL}
        Fill Text            css=input[data-testid='password']  126459
        Check Checkbox       css=input[data-testid='checkbox']
        Click                css=button[data-testid='cadastrar']
    
Conferir usuario cadastrado com sucesso  
        Wait For Elements State     h1    visible
        Get Text                    h1  ==  Bem Vindo Lucas GSM
        Get Element States          css=button[data-testid='logout']  validate  value & visible
        

Conferir usuario na lista de usuarios cadastrados
        Click                          css=a[data-testid='listar-usuarios']
        Sleep                           2
         ${elemento}                   Get Table Cell Element        css=table     "Nome"    " ${EMAIL}"
         ${usuario_nome}               Get Text    ${elemento}  ==  Lucas GSM
             
         Wait For Elements State       h1    visible
         Get Text                      h1  ==  Lista dos usuários

Cadastrar novo produto e conferir que aparece na listagem
        Click                                       css=a[data-testid='cadastrar-produtos']
        Wait For Elements State                     h1    visible
       ${paginaProd1}   Get Text                    h1  ==  Cadastro de Produtos
       Highlight Elements    ${paginaProd1}
       Take Screenshot        fullPage=${True}
       Fill Text            id=nome            PRODUTO TESTE1 
       Fill Text            id=price           100
       Fill Text            id=description     ESTE É UM PRODUTO DE TESTE AUTOMATIZADO
       Fill Text            id=quantity        10
       Click                xpath=//*[@id="root"]/div/div/div/form/div[6]/div/button

       Sleep    5
