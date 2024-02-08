@echo off

rem Define ANSI escape sequences for color
set "ESC="

rem Define color codes
set "GREEN=%ESC%[92m"  rem Green color
set "RED=%ESC%[91m"    rem Red color
set "MAGENTA=%ESC%[95m"    rem Magenta color
set "YELLOW=%ESC%[93m"    rem Yellow color
set "BLUE=%ESC%[94m"    rem Blue color
set "CYAN=%ESC%[96m"    rem Cyan color
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
    call :echoGreen TestCase %%x passed!
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
    call :echoRed Mismatched!
    @REM echo Mismatched!
    call :echoMagenta Input: 
    @REM echo Input:
    type input.in
    echo.

    call :echoMagenta Output:
    @REM echo Output:
    type output.out
    echo.

    call :echoMagenta Expected:
    @REM echo Expected:
    type output2.out
    echo.
) else (
    echo.
    call :echoYellow All testCases passed :D
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

:echoRed
echo off
cmd /c "echo %RED%%*%RESET%"
exit /b

:echoMagenta
echo off
cmd /c "echo %MAGENTA%%*%RESET%"
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
```
