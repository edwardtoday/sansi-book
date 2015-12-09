# Create a portable MariaDB database

Download `mariadb-version-win32.zip` from [https://mariadb.com/my_portal/download/mariadb](https://mariadb.com/my_portal/download/mariadb).

Provide a `my.ini` configuration. Depending on the hardware configuration of the server, you may start with the samples `my-small.ini`, `my-medium.ini`, `my-large.ini`, `my-huge.ini` and `my-innodb-heavy-4G.ini`.

Apply the customized configurations to `my.ini` such as encoding settings, turning on events support and so on.

Running `bin\mysqld.exe` will start a server instance immediately.

To create a system service, run `bin\mysql_install_db.exe --datadir=".\data" --service=MySQL --password=root`, where data directory, service name and root password are given.

To start the service, run `sc start MySQL`.

To stop the service, run `sc stop MySQL`.

To delete the service ,run `sc delete MySQL`.

You will need administrator previledge to run the commands above. To request administrator previledge before execution, add the following at the beginning of the batch file.

```
@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
```
