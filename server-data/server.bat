@echo off
:menu
cls
color 4


::: _____       _    _ _      _____  _____ _______       _   _  ____   _____ 
:::|  __ \ /\  | |  | | |    |_   _|/ ____|__   __|/\   | \ | |/ __ \ / ____|
:::| |__) /  \ | |  | | |      | | | (___    | |  /  \  |  \| | |  | | (___  
:::|  ___/ /\ \| |  | | |      | |  \___ \   | | / /\ \ | . ` | |  | |\___ \ 
:::| |  / ____ \ |__| | |____ _| |_ ____) |  | |/ ____ \| |\  | |__| |____) |
:::|_| /_/    \_\____/|______|_____|_____/   |_/_/    \_\_| \_|\____/|_____/ 


                                                                                                  
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A  
                            
echo 1- S T A R T  S E R V E     
echo 2- D E L E T E  C A C H E   
echo 3- R E N I C I A R  A  C A D A  1 2  H O R AS

set /p opcao=   E S C O L H A   A  F O R M A  D E  I N I C I A R  O  S E R V E R: 
color
if %opcao% equ 1 goto opcao1
if %opcao% equ 2 goto opcao2
if %opcao% equ 3 goto opcao3

:opcao1
cls
start ..\run.cmd +exec server.cfg
exit
goto menu


:opcao2
rd /s /q "cache"
goto menu

:opcao3
@echo off
color a
:loop
rd /s /q "cache"
@echo (%time%)  Server Reiniciou e apagou Cache
@echo Pressione Enter nesta janela para reiniciar o servidor imediatamente, mantenha esta janela aberta para reinicializacoes automaticas do servidor de 12 em 12 horas.
start "Server"  ..\run.cmd +exec server.cfg +set onesync on +set sv_enforceGameBuild 2189
timeout /t 43200
taskkill /f /im FXServer.exe
@echo Encerramento do servidor com sucesso.
timeout /t 2 >nul
taskkill /F /FI "WindowTitle eq Server"
@echo Servidor esta reiniciando agora.
timeout /t 5
cls
goto loop


goto menu