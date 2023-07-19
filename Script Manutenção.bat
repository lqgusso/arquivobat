@echo off
cls
:menu
cls
color 70

date /t

echo Computador: %computername%        Usuario: %username%
echo ------------------------------------------------------                   
echo    MENU CORRECAO WIN 10 E WIN 11
echo  ==================================
echo * 1. Desinstalar Aplicativos Nativos  * 
echo * 2. Corrigir WSUS                    *
echo * 3. Exibir Aplicativos Instalados    *
echo * 4. Informacoes da ET                *
echo * 5. Sair                             * 
echo  ==================================

set /p opcao= Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1 goto opcao1
if %opcao% equ 2 goto opcao2
if %opcao% equ 3 goto opcao3
if %opcao% equ 4 goto opcao4
if %opcao% equ 5 goto opcao5
if %opcao% GEQ 6 goto opcao6

:opcao1
cls
Get-AppxPackage officehub | Remove-AppxPackage
Get-AppxPackage skypeapp | Remove-AppxPackage
Get-AppxPackage windowsmaps | Remove-AppxPackage
Get-AppxPackage solitairecollection | Remove-AppxPackage
Get-AppxPackage windowsphone | Remove-AppxPackage
Get-AppxPackage windowsstore | Remove-AppxPackage
Get-AppxPackage xboxapp | Remove-AppxPackage
winget uninstall “Microsoft Pay”
echo =======================================
echo *      Aplicativos Desinstalados    *
echo =======================================
pause
goto menu

:opcao2
cls
echo ==================================
echo *    ATUALIZANDO WSUS        *
echo ==================================
echo Configuracoes atuais do WSUS:
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
pause
echo ========================================
echo *    ATUALIZANDO OS REGISTROS        *
echo ========================================
[HKEY_LOCAL_MACHINESOFTWARE]

[HKEY_LOCAL_MACHINESOFTWAREPolicies]

[HKEY_LOCAL_MACHINESOFTWAREPoliciesMicrosoft]

[HKEY_LOCAL_MACHINESOFTWAREPoliciesMicrosoftWindows]

[HKEY_LOCAL_MACHINESOFTWAREPoliciesMicrosoftWindowsWindowsUpdate]
"WUServer"="http://ip_servidor"
"WUStatusServer"="http://ip_servidor"

[HKEY_LOCAL_MACHINESOFTWAREPoliciesMicrosoftWindowsWindowsUpdateAU]
"AUOptions"=dword:00000004
"AutoInstallMinorUpdates"=dword:00000001
"DetectionFrequency"=dword:00000006
"DetectionFrequencyEnabled"=dword:00000001
"NoAutoRebootWithLoggedOnUsers"=dword:00000001
"NoAutoUpdate"=dword:00000000
"RebootRelaunchTimeoutEnabled"=dword:00000001
"RebootRelaunchTimeout"=dword:0000001e
"RescheduleWaitTime"=dword:0000003c
"RescheduleWaitTimeEnabled"=dword:00000001
"ScheduledInstallDay"=dword:00000000
"ScheduledInstallTime"=dword:00000003
"UseWUServer"=dword:00000001
echo Novas configuracoes:
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
echo Acesse via browser o endereço "http://ip_servidor/selfupdate/wuident.cab" (sem as aspas e ), caso seja solicitado o download do arquivo "wuident.cab" a estação está conseguindo receber arquivos do servidor".
wuauclt.exe /detectnow /resetauthorization
pause
goto menu

:opcao3
cls
echo ==================================
echo *     Aplicativos Instalados    *
echo ==================================
winget list
pause
goto menu

:opcao4
cls
echo ==============================================================
echo                *     Informacoes do Sistema    *
echo ==============================================================
systeminfo
echo NUMERO DE SERIE: 
wmic bios get serialnumber
echo LICENCA WINDOWS:
wmic path softwarelicensingservice get OA3xOriginalProductKey
winver
slmgr /dli
pause
goto menu

:opcao5
cls
exit

:opcao6
echo ==============================================
echo * Opcao Invalida! Escolha outra opcao do menu *
echo ==============================================
pause
goto menu
