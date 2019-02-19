ECHO OFF
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
netsh interface ipv4 set subinterface "Wi-Fi" mtu=1500 store=persistent
CLS
set status=Stopped
set /a value=256
:MENU
IF %status%==Stopped set display=1500
IF %status%==Started set display=%value%
ECHO.
ECHO ...............................................
ECHO         MTU ADV      :      %Status%: %display%           		
ECHO ...............................................
ECHO.
ECHO 1 - Start
ECHO 2 - Stop
ECHO 3 - Configuration 
ECHO q - EXIT
ECHO.
SET /P M=Type:
IF %M%==1 GOTO Start
IF %M%==2 GOTO Stop
IF %M%==3 GOTO Config
IF %M%==q GOTO EXIT
:Start
netsh interface ipv4 set subinterface "Ethernet" mtu=%value% store=persistent
IF errorlevel 1 GOTO Error 
netsh interface ipv4 set subinterface "Ethernet" mtu=%value% store=persistent
netsh interface ipv4 set subinterface "Wi-Fi" mtu=%value% store=persistent
set status=Started
cls
GOTO MENU
:Stop
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
netsh interface ipv4 set subinterface "Wi-Fi" mtu=1500 store=persistent
set status=Stopped
cls
GOTO MENU
:Config
netsh interface ipv4 show subinterface
GOTO Menu
:Error
set /a value+=10
GOTO Start
