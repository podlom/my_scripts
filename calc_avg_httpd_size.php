<?php

/*
 * HTTPD memory calculator
 *
 * This script calculates memory used by web server Apache (httpd), average httpd process size in Mb
 * 
 *
 * @author Shkodenko V. Taras (taras -at- shkodenko.com)
 * @requires ps, gawk, web server Apache process name (httpd|apache2)
 *
 */

// Apache 2 process name depends on OS e.g.: Red Hat, CentOs: httpd; Debian, Ubuntu: apache2
$httpd_name = "httpd";
//
$cmd1 = "ps -C '{$httpd_name}' -O rss | gawk '{ count ++; sum += $2 }; END {count --; print \"Number of processes =\",count; print \"Average memory usage per process =\", sum/1024/count , \"MB\"; print \"Total memory usage =\", sum/1024, \"MB\" ;};'";
// 
echo __FILE__ . ' +' . __LINE__ . ' running command: ' . $cmd1 . PHP_EOL;

exec($cmd1, $cmd_output, $res1);

// echo __FILE__ . ' +' . __LINE__ . ' command result: ' . var_export($res1, 1) . PHP_EOL;
// echo __FILE__ . ' +' . __LINE__ . ' command output: ' . PHP_EOL . var_export($cmd_output, 1) . PHP_EOL;

if ( !empty($cmd_output) ) {
    foreach ($cmd_output as $rep_line) {
        echo $rep_line . PHP_EOL;
    }
}
