@rem echo off
@rem
@rem @author Shkodenko V. Taras <taras@shkodenko.com>
@rem
@rem Run codepation acceptance tests and generate report in HTML format
@rem
@set testing_dir=C:\os\OSPanel\domains\pw\testing
echo "Set testing dir to: %testing_dir%"
@rem pause
@set reports_dir=C:\os\OSPanel\domains\pw\test-reports\
echo "Set reports dir to: %reports_dir%"
@rem pause
dir %reports_dir%
@rem
@For /f "tokens=1-3 delims=. " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
@For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a-%%b)
@rem
cd /d %testing_dir%
vendor\bin\codecept.bat run acceptance --steps --no-colors --html="%reports_dir%report_%mydate%_%mytime%.html"
pause
@rem Clean-up mess with report file names containing spaces
cd /d %reports_dir%
php fix-test-report-names.php
dir %reports_dir%
pause
