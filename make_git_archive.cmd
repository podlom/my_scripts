@echo off
@rem
@rem @author Shkodenko V. Taras <taras@shkodenko.com>
@rem
@rem @see: https://stackoverflow.com/questions/203090/how-do-i-get-current-datetime-on-the-windows-command-line-in-a-suitable-format
@rem
dir "C:\os\OSPanel\domains\pw\test-backups\"
@rem
@For /f "tokens=1-3 delims=. " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
@For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a-%%b)
@rem
cd /d "C:\os\OSPanel\domains\pw\testing"
@rem
git archive HEAD --format=zip -o "C:\os\OSPanel\domains\pw\test-backups\testing_cf-phalcon_%mydate%_%mytime%.zip"
@rem
cd "C:\os\OSPanel\domains\pw\test-backups\"
php fix-zip-names.php
dir "C:\os\OSPanel\domains\pw\test-backups\"
pause
