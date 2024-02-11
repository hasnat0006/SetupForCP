@echo off

@REM if you don't need any color in your terminal, you just comment out the call :_________ lines and uncomment the echo lines.


rem Define ANSI escape sequences for color
set "ESC="

rem Define color codes
set "GREEN=%ESC%[38;2;0;230;0m"        rem Green color
set "RED=%ESC%[38;2;255;0;0m"          rem Red color
set "MAGENTA=%ESC%[38;2;170;0;140m"    rem Magenta color
set "YELLOW=%ESC%[38;2;210;240;0m"     rem Yellow color
set "BLUE=%ESC%[38;2;0;10;250m"        rem Blue color
set "CYAN=%ESC%[38;2;0;160;160m"       rem Cyan color
set "BOLD=%ESC%[1m"                    rem Bold
set "UNDERLINE=%ESC%[4m"               rem Underline
set "RESET=%ESC%[0m"

if [%1]==[] (set /A numLoop = 100) else (set /A numLoop = %1)
if [%2]==[] (set /A doComp = 1) else (set /A doComp = %2)

if %doComp% equ 1 (
    call :echoYellow Compiling solution, gen, brute...
    @REM echo Compiling solution, gen, brute...
    g++ -std=c++17 gen.cpp -o gen
    g++ -std=c++17 solution.cpp -o solution
    g++ -std=c++17 brute.cpp -o brute
    call :echoYellow Compilation completed!
    @REM echo Compilation completed!
    echo.
)

set "diff_found="

for /l %%x in (1, 1, %numLoop%) do (
    call :echoBoldDeepGreen [ TestCase %%x: passed! ]
    @REM echo TestCase %%x passed!
    gen > input.in
    solution < input.in > output.out 
    brute < input.in > output2.out
    rem add \f after "fc" to ignore trailing whitespaces and to convert
    rem multiple whitespaces into one space
    fc output.out output2.out > diagnostics
    if errorlevel 1 (
        set "diff_found=y"
        goto :break
    )
)

:break

if defined diff_found (
    echo.
    call :echoRed [   Wrong answer:(   ]
    @REM echo Wrong answer:(
    echo.
    call :echoBoldUnderlineCyan Input: 
    @REM echo Input:
    echo.
    call :echoMagentaFromFile input.in
    @REM type input.in
    echo.

    call :echoBoldUnderlineCyan Your output:
    @REM echo Output:
    echo.
    call :echoMagentaFromFile output.out
    @REM type output.out
    echo.

    call :echoBoldUnderlineCyan Expected output:
    @REM echo Expected:
    echo.
    call :echoMagentaFromFile output2.out
    @REM type output2.out
    echo.
) else (
    echo.
    call :echoBoldDeepGreen All testcases passed :D
    @REM echo All testCases passed :D
)

del input.in
del output.out
del output2.out
del gen.exe
del solution.exe
del brute.exe
del diagnostics
exit /b

:echoGreen
echo off
cmd /c "echo %GREEN%%*%RESET%"
exit /b

:echoBoldDeepGreen
echo off
cmd /c "echo %GREEN%%BOLD%%*%RESET%"
exit /b

:echoRed
echo off
cmd /c "echo %RED%%*%RESET%"
exit /b


:echoMagenta
echo off
cmd /c "echo %MAGENTA%%*%RESET%"
exit /b

:echoBoldUnderlineDeepMagenta
echo off
cmd /c "echo %MAGENTA%%BOLD%%UNDERLINE%%*%RESET%"

exit /b

:echoYellow
echo off
cmd /c "echo %YELLOW%%*%RESET%"
exit /b

:echoBlue
echo off
cmd /c "echo %BLUE%%*%RESET%"
exit /b

:echoCyan
echo off
cmd /c "echo %CYAN%%*%RESET%"
exit /b

:echoRedFromFile
echo off
setlocal enabledelayedexpansion
for /f "tokens=*" %%a in (%1) do (
    echo %RED%%%a%RESET%
)
exit /b

:echoMagentaFromFile
echo off
setlocal enabledelayedexpansion
for /f "tokens=*" %%a in (%1) do (
    echo %MAGENTA%%%a%RESET%
)
exit /b

:echoBoldUnderlineCyan
echo off
cmd /c "echo %CYAN%%BOLD%%UNDERLINE%%*%RESET%"
exit /b
```
