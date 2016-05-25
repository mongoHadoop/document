@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM  Copyright (c) 2000, 2008 ShenZhen Kingdee Middleware Co.,Ltd.
REM  All Rights Reserved.

:APUSIC_HELP
if "%1" == "help" goto START_HELP
if "%1" == "-help" goto START_HELP
if "%1" == "/?" goto START_HELP
goto NOT_HELP

:START_HELP
echo Usage: startapusic [options]
echo where startapusic options include:
echo. startapusic               start apusic in normal mode.
echo. startapusic -d[ebug]      start apusic in debug mode.
echo. startapusic -d[ebug]s     start apusic in debug suspending mode.
echo. startapusic -p[roduct]    start apusic in product mode.
echo. startapusic -v[erbose]    show environment variables for apusic server startup.
echo. startapusic -v[erbose]a   show all environment variables for apusic server startup.
goto THE_END

:NOT_HELP
cd /d %~dp0

if exist setenv.cmd goto SETENV
echo Unable to initialize the environment variables
echo File setenv.cmd not exists, Please check your apusic installation
goto THE_END

:SETENV
call setenv.cmd

@REM Change the value of "user.dir" property
cd %DOMAIN_HOME%

echo Using JAVA_HOME:      %JAVA_HOME%
echo Using APUSIC_HOME:    %APUSIC_HOME%
echo Using DOMAIN_HOME:    %DOMAIN_HOME%
echo.
echo CLASSPATH=%CLASSPATH%
echo.
echo PATH=%PATH%
echo.

if "%1" == "-debug" goto START_DEBUG
if "%1" == "-d" goto START_DEBUG
if "%1" == "-debugs" goto START_DEBUG_SUSPEND
if "%1" == "-ds" goto START_DEBUG_SUSPEND
if "%1" == "-product" goto START_PRODUCT
if "%1" == "-p" goto START_PRODUCT
if "%1" == "-verbose" goto START_VERBOSE
if "%1" == "-v" goto START_VERBOSE
if "%1" == "-va" goto START_VERBOSE_PROPERTY

:START_NORMAL
set JVM_OPTS=-server -Xms512m -Xmx1024m -XX:MaxPermSize=256m -Dais.agent.dir=%DOMAIN_HOME%/agent -Dais.server.home=%DOMAIN_HOME%/aisServer
echo Using JVM_OPTS:       %JVM_OPTS%
echo.
echo starting apusic in normal mode......
echo.
%JAVA_RUN% -Dcom.apusic.domain.home="%DOMAIN_HOME%" %JVM_OPTS% com.apusic.server.Main -root "%APUSIC_HOME%"
goto THE_END

:START_DEBUG
set JPDA_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,server=y,address=8000,suspend=n -server -Xms512m -Xmx1024m -XX:MaxPermSize=256m -Dais.agent.dir=%DOMAIN_HOME%/agent -Dais.server.home=%DOMAIN_HOME%/aisServer
echo Using JPDA_OPTS:      %JPDA_OPTS%
echo.
echo starting apusic in debug mode......
echo.
%JAVA_RUN% -Dcom.apusic.domain.home="%DOMAIN_HOME%" %JVM_OPTS% %JPDA_OPTS% com.apusic.server.Main -root "%APUSIC_HOME%"
goto THE_END

:START_DEBUG_SUSPEND
set JPDA_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,server=y,address=8000,suspend=y
echo Using JPDA_OPTS:      %JPDA_OPTS%
echo.
echo starting apusic in debug suspending mode......
echo.
%JAVA_RUN% -Dcom.apusic.domain.home="%DOMAIN_HOME%" %JVM_OPTS% %JPDA_OPTS% com.apusic.server.Main -root "%APUSIC_HOME%"
goto THE_END

:START_PRODUCT
set JVM_OPTS=-server -Xms512m -Xmx1024m -XX:MaxPermSize=256m -Dais.agent.dir=%DOMAIN_HOME%/agent -Dais.server.home=%DOMAIN_HOME%/aisServer
echo Using JVM_OPTS:       %JVM_OPTS%
echo.
echo starting apusic in product mode......
echo.
%JAVA_RUN% -Dcom.apusic.domain.home="%DOMAIN_HOME%" %JVM_OPTS% com.apusic.server.Main -root "%APUSIC_HOME%"
goto THE_END

:START_VERBOSE
echo show environment variables for apusic server startup......
echo.
%JAVA_RUN% -Dcom.apusic.domain.home="%DOMAIN_HOME%" -Dapusic.verbose=true com.apusic.server.Main -root "%APUSIC_HOME%"
goto THE_END

:START_VERBOSE_PROPERTY
echo show all environment variables for apusic server startup......
echo.
%JAVA_RUN% -Dcom.apusic.domain.home="%DOMAIN_HOME%" -Dapusic.verbose.property=true com.apusic.server.Main -root "%APUSIC_HOME%"
goto THE_END

:THE_END
endlocal
