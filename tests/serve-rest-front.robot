*** Settings ***
Resource    ../resources/serve-rest-front.resource
Suite Teardown    Close Browser    ALL

*** Test Cases ***
Login com sucesso serve Rest front
        Abrir o Navegador
        Ir para o site
        Cadastrar novo usuario    
        Conferir usuario cadastrado com sucesso  
        Conferir usuario na lista de usuarios cadastrados


Cadastrar novo produto
         Abrir o Navegador
        Ir para o site
        Cadastrar novo usuario 
        Cadastrar novo produto e conferir que aparece na listagem 

        



 