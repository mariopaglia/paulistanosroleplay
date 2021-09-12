:: TEXTO DE INICIALIZAÇÃO

@echo off
echo [%TIME:~-0,8% - %DATE%] - Iniciando o sistema...

:: echo #############################################################################################################
:: echo #                                                  ____                                                     #
:: echo #                                                 / __ ) __  __                                             #
:: echo #                                                / __  )/ / / /                                             #
:: echo #                                               / /_/ // /_/ /                                              #
:: echo #                                              /_____/ \__, /                                               #
:: echo #                                                     /____/                                                #
:: echo #      ____                       ____                     __                 __ __   _____ ___ ____  ___   #
:: echo #     / __ \ ____   ____ ___     / __ \ ___   _____ _____ / /___   _____   __/ // /_ /__  //  // __ \/__ \  #
:: echo #    / / / // __ \ / __ `__ \   / /_/ // _ \ / ___// ___// // _ \ / ___/  /_  _  __/  /_ / / // / / /__/ /  #
:: echo #   / /_/ // /_/ // / / / / /  / _, _//  __/(__  )(__  )/ //  __// /     /_  _  __/ ___/ // // /_/ // __/   #
:: echo #  /_____/ \____//_/ /_/ /_/  /_/ \_\ \___//____//____//_/ \___//_/       /_//_/   /____//_/ \____//____/   #
:: echo #                                                                                                           #
:: echo #-----------------------------------------------------------------------------------------------------------#
:: echo #----------------------------------------- Sistema de RR automatico ----------------------------------------#
:: echo #-----------------------------------------------------------------------------------------------------------#
:: echo #############################################################################################################

:: echo -
:: echo Pressione uma tecla para iniciar o servidor...
:: echo -
:: pause > nul
:: timeout /T 5
:: CLS

:: CONFIGURAÇÃO

TITLE [NAO FECHAR] - RR AUTO - [NAO FECHAR] - SISTEMA DE AUTO RR - [NAO FECHAR]
set reboot=6:00
set reboot2=17:00
set reboot_done=0
set reboot_done2=0

:: CMD DO RR

:start

echo [%TIME:~-0,8% - %DATE%] - Limpando o cache do servidor...
RMDIR /s /q "C:\paulistanosroleplay\server-data\cache"
timeout /T 10
echo [%TIME:~-0,8% - %DATE%] - Reiniciando o servidor...
start ..\FXServer.exe +set onesync on +set sv_enforceGameBuild 2189 +exec server.cfg

:: LOOP DO PRIMEIRO RR

goto loop

:loop
timeout /t 30>null
set tps=%TIME:~-0,5%
    if %tps% == %reboot% (
        if %reboot_done% == 0 (
            echo [%TIME:~-0,8% - %DATE%] - Desligando o servidor para o RR das %reboot% horas...
            taskkill /f /im FXServer.exe /fi "memusage gt 40" 2>NUL | findstr SUCCESS >NUL
			echo ----------------------------------------------------------------------
            set reboot_done=1
            goto start
        ) else (
            goto loop
        )
    ) else (
        set reboot_done=0
        goto loop
    )

:: LOOP DO SEGUNDO RR

goto loop

:loop

timeout /t 30>null
set tps2=%TIME:~-0,5%
    if %tps2% == %reboot2% (
        if %reboot_done2% == 0 (
            echo [%TIME:~-0,8% - %DATE%] - Desligando o servidor para o RR das %reboot2% horas...
			taskkill /f /im FXServer.exe /fi "memusage gt 40" 2>NUL | findstr SUCCESS >NUL
			echo ----------------------------------------------------------------------
            set reboot_done2=1
            goto start
        ) else (
            goto loop
        )
    ) else (
        set reboot_done2=0
        goto loop
    )