<?php

/*
 * MySQL max memory calculator
 *
 * This script calculates maximum possible memory usage by MySQL service based on current server configuration
 * 
 * Based on http://www.mysqlcalculator.com/
 *
 * @author Shkodenko V. Taras (taras -at- shkodenko.com)
 * @requires PHP 5.X
 * @requires MySQL 5.X
 *
 */

define('VERSION', '1.0');


// command line arguments; check below for usage
$cmdArgs = getopt('h:u:p');

// connect to mysql database
$dbHost = isset($cmdArgs['h']) ? $cmdArgs['h'] : ini_get("mysqli.default_host");
$dbUser = isset($cmdArgs['u']) ? $cmdArgs['u'] : ini_get("mysqli.default_user");
$dbPass = isset($cmdArgs['p']) ? $cmdArgs['p'] : ini_get("mysqli.default_pw");

// check args
if ( strlen($cmdArgs['h']) > 0 && strlen($cmdArgs['u']) > 0 && strlen($cmdArgs['p']) > 0 ) {
	displayUsage();
}

// get variables
$getMySQLVariables = 'mysql -h ' . $cmdArgs['h'] . ' -u ' . $cmdArgs['u'] . ' -p' . $cmdArgs['p'] . ' -e "SHOW VARIABLES"';
echo __FILE__ . ' +' . __LINE__ . ' running command: ' . $getMySQLVariables . PHP_EOL;

exec($getMySQLVariables, $aOut1, $resCmd1);

// echo 'Command result: ' . var_export($resCmd1, 1) . PHP_EOL;
// echo 'Command output: ' . var_export($aOut1, 1) . PHP_EOL;

$fv = array();
if ( is_array($aOut1) && count($aOut1) ) {
	$i = 0;
	$searchKeys = array('key_buffer_size', 'query_cache_size', 'tmp_table_size', 'innodb_buffer_pool_size', 'innodb_additional_mem_pool_size', 'innodb_log_buffer_size', 'max_connections', 'sort_buffer_size', 'read_buffer_size', 'read_rnd_buffer_size', 'join_buffer_size', 'thread_stack', 'binlog_cache_size');
	$cntSrch = count($searchKeys);
	foreach ($aOut1 as $v1) {
		$a1 = preg_split("/[\s]+/", $v1);
		if ( !empty($a1[0]) ) {
			if ( isset($a1[0]) ) {
				$varName = trim($a1[0]);	
			}
			if ( isset($a1[1]) ) {
				$varVal1 = trim($a1[1]);	
			}
			if( in_array($varName, $searchKeys) ) {
				$fv[ $varName ] = $varVal1;
			}
			++ $i;
		}
	}
}

$cntFound = count($fv);

if ( $cntFound == $cntSrch ) {
	echo 'All ' . $cntSrch . ' required variables has found.'. PHP_EOL;
} else {
	echo 'Found ' . $cntFound . ' of ' . $cntSrch . ' variables has found.'. PHP_EOL;
}
// echo 'Checked MySQL variable values are: ' . var_export($fv, 1) . PHP_EOL;

/*

Memory usage = key_buffer_size + query_cache_size + tmp_table_size + innodb_buffer_pool_size + innodb_additional_mem_pool_size + innodb_log_buffer_size + max_connections × sort_buffer_size + read_buffer_size + read_rnd_buffer_size + join_buffer_size + thread_stack + binlog_cache_size

*/

$mb = 1024 * 1024;
$res_mb1 = ($fv['key_buffer_size']/$mb) +	($fv['query_cache_size']/$mb) +	($fv['tmp_table_size']/$mb) +	($fv['innodb_buffer_pool_size']/$mb) + ($fv['innodb_additional_mem_pool_size']/$mb) +	($fv['innodb_log_buffer_size']/$mb) +	$fv['max_connections'] * ( ($fv['sort_buffer_size']/$mb) + ($fv['read_buffer_size']/$mb) +	($fv['read_rnd_buffer_size']/$mb) +	($fv['join_buffer_size']/$mb) +	($fv['thread_stack']/$mb) + ($fv['binlog_cache_size']/$mb) );

// Show variable values in Mb
echo PHP_EOL . 'List of variables used in calculation: ' . PHP_EOL;
foreach ($fv as $k19 => $v19) {
	if ( $k19 != 'max_connections' ) {
		echo $k19 . ': ' . $fv[ $k19 ] . ' / ' . $mb . ' = ' . ($fv[ $k19 ] / $mb) . PHP_EOL;
	} else {
		echo $k19 . ': ' . $fv[ $k19 ] . PHP_EOL;
	}
}

echo PHP_EOL . 'Using formula: Memory usage = key_buffer_size + query_cache_size + tmp_table_size + innodb_buffer_pool_size + innodb_additional_mem_pool_size + innodb_log_buffer_size + max_connections × sort_buffer_size + read_buffer_size + read_rnd_buffer_size + join_buffer_size + thread_stack + binlog_cache_size' . PHP_EOL;
echo PHP_EOL . 'Maximum possible MySQL memory usage, Mb: ' . $res_mb1 . PHP_EOL;



 
/**
 * displayUsage(): display a usage message and exit
 *
 */
function displayUsage() {
	$version = VERSION;
	$script = __FILE__;
	echo <<<QQ
{$_SERVER['SCRIPT_NAME']} v{$version}: Calculate maximum possible memory usage by MySQL service.
Usage: {$script} [options]
 -h <host name>     The host to connect to; default is localhost
 -u <username>      The user to connect as
 -p <password>      The user's password

 
QQ;

	exit;
}
