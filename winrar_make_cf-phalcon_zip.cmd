@echo off
@rem
@rem @author Shkodenko V. Taras <taras@shkodenko.com>
@rem
@set app_folder=C:\os\OSPanel\domains\pw\
@set prefix=cf-phalcon
echo "Making %app_folder%%prefix% archive..."
@for /f "tokens=1-3 delims=. " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
@for /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a-%%b)
cd /d %app_folder%
dir
pause
"C:\Program Files\WinRAR\WinRAR.exe" a -afzip -r "%prefix%_%mydate%_%mytime%.zip" "%prefix%\*.*"
