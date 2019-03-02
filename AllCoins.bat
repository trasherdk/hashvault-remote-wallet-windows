@ECHO OFF

REM Access all your wallets with one command line program
TITLE HashVault public nodes for wallets

GOTO START

:START
COLOR a
PUSHD "%~dp0"

ECHO SELECT A COIN
ECHO.
ECHO AEON
ECHO DERO
ECHO ETN (Electroneum)
ECHO GRFT (Graft)
ECHO ITNS (IntenseCoin)
ECHO KRB (Karbo)
ECHO LOK (Loki)
ECHO MSR (Masari)
ECHO RYO 
ECHO SUMO
ECHO XHV (Haven Protocol)
ECHO XMR (Monero)
ECHO XTL (Stellite)
ECHO.

SET /p coin=
IF %coin%==x EXIT
IF NOT EXIST "%coin%\" (
	COLOR C
	ECHO Invalid selection, or folder with wallet is missing
	TIMEOUT 3
	CLS
	GOTO START
)
CD %coin%
GOTO choice

:choice
CLS  
ECHO %coin% wallet options
ECHO 1) Open wallet
ECHO 2) Restore from keys
ECHO 3) Restore from seed
ECHO 4) Start new wallet

CHOICE /C 1234 /N
GOTO %ERRORLEVEL%

:1
CD data
ECHO.
ECHO Available wallets:
ECHO.
DIR /B *. | findstr /v /i ".gitkeep$" 
ECHO.
SET /p walletName=Load wallet:
SET arg=--wallet-file=%walletName%
cd..
GOTO exec


:2
SET /p walletName=Name of your new wallet:
SET arg=--generate-from-keys=%walletName%
GOTO exec

:3
SET /p walletName=Name of your new wallet:
SET arg=--generate-new-wallet=%walletName% --restore-deterministic-wallet
GOTO exec

:4
SET /p walletName=Name of your new wallet:
SET arg=--generate-new-wallet=%walletName%
GOTO exec

:exec

REM Look mom! I haven't used look-up tab-... Oh. 
IF /I %coin% == AEON (SET execFile=aeon-wallet-cli.exe)
IF /I %coin% == DERO (SET execFile=dero-wallet-cli-windows-amd64.exe)
IF /I %coin% == ETN  (SET execFile=electroneum-wallet-cli.exe)

IF /I %coin% == GRFT (SET execFile=graft-wallet-cli.exe)
IF /I %coin% == ITNS (SET execFile=intense-wallet-cli.exe)
IF /I %coin% == KRB  (SET execFile=karbowanecd.exe)

IF /I %coin% == LOK (SET execFile=loki-wallet-cli.exe)
IF /I %coin% == MSR (SET execFile=masari-wallet-cli.exe)
IF /I %coin% == RYO (SET execFile=ryo-wallet-cli.exe)

IF /I %coin% == SUMO (SET execFile=sumo-wallet-cli.exe)
IF /I %coin% == XHV (SET execFile=haven-wallet-cli.exe)
IF /I %coin% == XMR (SET execFile=monero-wallet-cli.exe)
IF /I %coin% == XTL (SET execFile=stellite-wallet-cli.exe)


REM Final words...
CLS
CD cli\
%execFile% %arg% --daemon-host=nodes.hashvault.pro

COLOR b
CHOICE /t 5 /d N /M "Wallet closed. Do you wish to go back to the main menu?"
IF ERRORLEVEL 2 EXIT

CLS
GOTO START
