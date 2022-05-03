ECHO OFF
CLS
set NL=^^^%NLM%%NLM%^%NLM%%NLM%


:MENU
cls
TITLE VgKiller --^> by DJD320#4415
echo [31mVanguardKiller Script[0m
ECHO.
ECHO ------------------------------------------------
ECHO 1 - Stop Vanguard.                             ^| 
ECHO 2 - Disable and Stop Vanguard.                 ^|
ECHO 3 - Enable Vanguard and restart your computer. ^|
ECHO 4 - EXIT.                                      ^|
ECHO ------------------------------------------------

ECHO.

SET /P M=[32mType 1, 2, 3, or 4 then press ENTER: [33m
IF %M%==1 GOTO StopOnly
IF %M%==2 GOTO DisableAndStop
IF %M%==3 GOTO EnableAndRestart
IF %M%==4 exit

echo.
echo [31mINVALID CHOICE.[0m
timeout 2 >nul
goto MENU


:StopOnly
:: Stops Vanguard.

net stop vgc >nul 2>&1
net stop vgk >nul 2>&1
taskkill /IM vgtray.exe >nul 2>&1
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Vanguard Stopped.', 'VanguardKiller Script', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
exit


:DisableAndStop
:: Disables and stops Vanguard.

sc config vgc start= disabled >nul 2>&1
sc config vgk start= disabled >nul 2>&1
net stop vgc >nul 2>&1
net stop vgk >nul 2>&1
taskkill /IM vgtray.exe >nul 2>&1
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Vanguard Stopped and Disabled.', 'VanguardKiller Script', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"

exit


:EnableAndRestart
sc config vgc start= demand >nul 2>&1
sc config vgk start= system >nul 2>&1
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Vanguard Stopped and Disabled.', 'VanguardKiller Script', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}" > nul
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('A reboot is required in order to be able to play Valorant, do you wanna reboot now?', 'VanguardKiller Script', 'YesNo', [System.Windows.Forms.MessageBoxIcon]::Warning);}" > %TEMP%\out.tmp
set /p OUT=<%TEMP%\out.tmp
if %OUT%==Yes shutdown /r /f /t 00
exit 
