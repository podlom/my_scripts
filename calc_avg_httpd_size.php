<?php

/*
 * HTTPD memory calculator
 *
 * This script calculates memory used by web server Apache (httpd), average httpd process size in Mb
 * 
 *
 * @author Shkodenko V. Taras (taras -at- shkodenko.com)
 * @requires web server Apache (httpd)
 *
 */

$httpd_name = "httpd";
//
$avg_httpd_size_data_cmd = "ps auxwww |grep '{$httpd_name}' |grep -v 'grep' |grep -v '" . __FILE__ . "' |awk '{print \$5/1024}'";
echo __FILE__ . ' +' . __LINE__ . ' running command: ' . $avg_httpd_size_data_cmd . PHP_EOL;

ob_start();
passthru($avg_httpd_size_data_cmd, $res1);
$cmd_output = ob_get_contents();
ob_end_clean();

// echo __FILE__ . ' +' . __LINE__ . ' command result: ' . var_export($res1, 1) . PHP_EOL;
// echo __FILE__ . ' +' . __LINE__ . ' command output: ' . PHP_EOL . var_export($cmd_output, 1) . PHP_EOL;

$a0 = array();
if( !empty($cmd_output) ) {
    preg_match_all('|\d+|m', $cmd_output, $a1);
    if( is_array($a1) && (count($a1) > 0) ) {
        foreach($a1 as $a2) {
            $a0[] = $a2;
        }
    }
    // echo var_export($a0[0], 1) . PHP_EOL;
    $avg_val = calculate_average($a0[0]);
    echo 'Average value memory, Mb: ' . intval($avg_val) . PHP_EOL;
}


/**
 * Float calculate_average(Array $arr): calculates avarage httpd process size, Mb
 */
function calculate_average($arr) {
    // total numbers in array
    $count = count($arr);
    echo 'Number of Apache children: ' . $count . PHP_EOL;
    $total = 0;
    foreach ($arr as $value) {
        // total value of array numbers
        $total = $total + $value;
    }
    echo 'Total memory usage by Apache children, Mb: ' . $total . PHP_EOL;
    // get average value
    $average = ($total/$count);
    return $average;
}

