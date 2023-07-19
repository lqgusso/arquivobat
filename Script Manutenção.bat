@echo off
cls
:menu
cls
color 90

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
echo *      WSUS concluido           *
echo ==================================
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
