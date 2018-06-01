@echo off
@rem
@rem @see: https://stackoverflow.com/questions/203090/how-do-i-get-current-datetime-on-the-windows-command-line-in-a-suitable-format
@rem
For /f "tokens=1-3 delims=. " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a-%%b)
cd /d C:\os\OSPanel\domains\pw\testing
git archive HEAD --format=zip -o testing_cf-phalcon_%mydate%_%mytime%.zip
