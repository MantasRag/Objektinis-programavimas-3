@echo off

echo   Studentai v3.0 - Installer Builder
echo.

REM Nustatyti konkretų NSIS kelią
set NSIS_EXE="C:\Program Files (x86)\NSIS\makensis.exe"

REM Patikrinti, ar NSIS egzistuoja
if not exist %NSIS_EXE% (
    echo [KLAIDA] NSIS nerastas
    echo Tikrintas kelias:
    echo   %NSIS_EXE%
    echo.
    echo Patikrinkite, ar NSIS idiegtas.
    pause
    exit /b 1
)

REM Patikrinti, ar programa sukompiliuota
if not exist "build\Studentai_v3.exe" (
    echo [KLAIDA] Vykdomasis failas nerastas
    echo Prasome pirmiausia paleisti build.bat
    pause
    exit /b 1
)

REM Patikrinti butinus failus
if not exist "license.txt" (
    echo [ĮSPĖJIMAS] license.txt failas nerastas
    echo MIT License > license.txt
    echo. >> license.txt
    echo Copyright ... >> license.txt
)

if not exist "README.txt" (
    echo [ĮSPĖJIMAS] README.txt failas nerastas
    echo Studentu programa v3.0 > README.txt
    echo Naudojimosi instrukcija >> README.txt
)

REM Kompiliuoti NSIS installer
echo [INFO] Kompiliuojamas installer su NSIS...
%NSIS_EXE% /V3 "%~dp0installer.nsi" || (
    echo.
    echo [KLAIDA] Installer kompiliavimas nepavyko
    pause
    exit /b 1
)

echo.
echo [SEKMINGA] Installer sukurtas
pause
