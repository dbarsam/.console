@echo off
REM ===================================================================
REM                  Console Environment Set-up File
REM ===================================================================

REM ==============
REM Global Environement
REM ==============



REM ==============
REM Individual Environement
REM ==============
if [%1]==[] (
    set TARGET=default
) else (
    set TARGET=%1
) 

REM Strip the first argument
shift
set PARAMS=%1
:loop
shift
if [%1]==[] goto endloop
set PARAMS=%PARAMS% %1
goto loop
:endloop

REM Switch on the First Variable
goto %TARGET%

REM ==============
:default
if exist %WORKDIR%\dotfiles\.cmd\profile.cmd (
    call %WORKDIR%\dotfiles\.cmd\profile.cmd %PARAMS%
    goto EXIT
)
goto ERROR

REM ==============
:VS2008
for %%p in ("%PROGRAMFILES%" "%PROGRAMFILES(x86)%") do (
    if exist %%p"\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" (
        call %%p"\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" %PARAMS%
        goto EXIT
    )
)
goto ERROR

REM ==============
:VS2010
for %%p in ("%PROGRAMFILES%" "%PROGRAMFILES(x86)%") do (
    if exist %%p"\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" (
        call %%p"\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" %PARAMS%
        goto EXIT
    )
)
goto ERROR

REM ==============
:XDK
for %%p in ("%PROGRAMFILES%" "%PROGRAMFILES(x86)%") do (
    if exist %%p"\Microsoft Xbox 360 SDK\bin\win32\xdkenv.bat" (
        call %%p"\Microsoft Xbox 360 SDK\bin\win32\xdkenv.bat" %PARAMS%
        goto EXIT
    )
)
goto ERROR

REM ==============
:GIT
for %%p in ("%PROGRAMFILES%" "%PROGRAMFILES(x86)%") do (
    if exist %%p\"Git\bin\sh.exe" (
        %%p\"Git\bin\sh.exe" --login -i
        goto EXIT
    )
)
goto ERROR


REM ==============
REM Error Handling
REM ==============
:ERROR
echo Loading "%TARGET%" environment failed!

REM ===================================================================
REM End of Script
REM ===================================================================
:EXIT

