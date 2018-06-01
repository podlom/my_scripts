@rem echo off
@rem
@rem @author Shkodenko V. Taras <taras@shkodenko.com>
@rem
@rem Run codepation acceptance tests and generate report in HTML format
@rem
cd /d "C:\os\OSPanel\domains\pw\testing"
dir
For /f "tokens=1-3 delims=. " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a-%%b)
vendor\bin\codecept.bat run acceptance --steps --html="C:\os\OSPanel\domains\pw\test-reports\report_%mydate%_%mytime%.html"
