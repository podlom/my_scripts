# my_scripts

Different scripts which might be useful in web servers configuration.


mysql_memory_calculator.php - MySQL maximum possible memory usage calculator.

Script usage:

```
$ php mysql_memory_calculator.php -h localhost -u root -p password
```


calc_avg_httpd_size.php - Apache (httpd) current memory usage, average process size memory calculator.

Script usage:

```
$ php calc_avg_httpd_size.php
```

get_email_user.php - Generate user account information based on user name

Script usage:

```
$ php get_email_user.php FirstName LastName
```

get_access_info.pl - Generate access information for (sub)domain(s) passed as argument(s)

Script usage:

```
$ ./get_access_info.pl test1.shkodenko.com [testn.com]
```

change_proxy_ip.sh - Change one IP address to another in Frox FTP, Squid HTTP & IPTables firewall one time automatically. Run as root administrator user

Script usage:

```
# ./change_proxy_ip.sh Old_IP New_IP
```

squid_reconfigure.sh - Check Squid HTTP proxy syntax. If it is OK - reconfigure & reload service. Run as root administrator user

Script usage:

```
# ./squid_reconfigure.sh
```

