@echo off
@rem
@rem @author Shkodenko V. Taras <taras@shkodenko.com>
@rem
@rem
cd /d "C:\os\OSPanel\domains\pw\_db_backups"
dir "C:\os\OSPanel\domains\pw\_db_backups"
@rem
For /f "tokens=1-3 delims=." %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a-%%b)
@rem
"C:\os\OSPanel\modules\database\MySQL-5.7-x64\bin\mysqldump.exe" -uroot cf-phalcon-clean > "C:\os\OSPanel\domains\pw\_db_backups\cf-phalcon-clean_taras_%mydate%_%mytime%.sql"
dir "C:\os\OSPanel\domains\pw\_db_backups"
pause
