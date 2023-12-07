# my_scripts

Different example scripts which might be useful in development and (or) web servers configuration.


- mysql_memory_calculator.php - MySQL maximum possible memory usage calculator.

Script usage:

```
$ php mysql_memory_calculator.php -h localhost -u root -p password
```


- calc_avg_httpd_size.php - Apache (httpd) current memory usage, average process size memory calculator.

Script usage:

```
$ php calc_avg_httpd_size.php
```

- get_email_user.php - Generate user account information based on user name

Script usage:

```
$ php get_email_user.php FirstName LastName
```

- get_random_password.php - Random password generator based on given linux.words.txt dictionary

Script usage:

```
$ php get_random_password.php [Optional password length]
```

- get_access_info.pl - Generate access information for (sub)domain(s) passed as argument(s)

Script usage:

```
$ ./get_access_info.pl test1.shkodenko.com [testn.com]
```

- change_proxy_ip.sh - Change one IP address to another in Frox FTP, Squid HTTP & IPTables firewall one time automatically. Run as root administrator user

Script usage:

```
# ./change_proxy_ip.sh Old_IP New_IP
```

- squid_reconfigure.sh - Check Squid HTTP proxy syntax. If it is OK - reconfigure & reload service. Run as root administrator user

Script usage:

```
# ./squid_reconfigure.sh
```

- generate_git_keys.sh - Generate git keys for new team member.

Script usage:

```
# ./generate_git_keys.sh User.Login
```

- proclog.sh - Get server statistics for future analysis. Can be added to cron to run automatically each N minutes

Script usage:
```
# ./proclog.sh
```

- get_new_php_doc.sh - Get fresh copy of PHP documentation with user comments in English

Script usage:
```
# ./get_new_php_doc.sh
```

- check-http-80.pl - Get number of HTTP connections made to web server Apache on WHM/cPanel servers

Script usage:
```
# ./check-http-80.pl
```

- mysql_process_list.sh - Get MySQL full process list data. Should be runned as user with MySQL root administrator privileges

Script usage:
```
# ./mysql_process_list.sh
```

- git_co_branch.sh - Git working trees synchronization helper script

Script usage:
```
# ./git_co_branch.sh BranchName
```

- linux_plesk_backup_mysql_databases.sh - Backup MySQL databases for Linux servers with Plesk control panel example script. Should be runned as root administrator user

Script usage:
```
# ./linux_plesk_backup_mysql_databases.sh
```

- backup_mysql_databases.sh - Backup MySQL databases for Linux servers with MySQL root user credentials defined in defaults /root/.my.cnf configuration file. Should be runned as root administrator user

Script usage:
```
# ./backup_mysql_databases.sh
```

- php_version_check.sh - PHP version checker

Script usage:
```
$ ./php_version_check.sh
```

- grep.php - Search for strings in PHP files & report found matches.

Script usage:

```
$ php grep.php "/path/to/web"
```


[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/L3L5LJ3TB)
