<?php

/**
 * Get phone link PHP cli script
 * Usage: php get-phone-link.php "+38 (067) 446-42-12"
 */

function digitOnly($str) {
	if (!empty($str)) {
		return preg_replace('/[^0-9]/', '', $str);
	}
}

function getPhoneLink($phone) {
	if (!empty($phone)) {
		$p0 = strpos($phone, 'ext');
		if ($p0 !== false) {
			preg_match('|(\+\d{2}\(\d{3}\)\d{3}-\d{2}-\d{2}) \(<\?= Yii::t\(\'app\', \'ext\.\'\) \?>(\d+)\)|', $phone, $m);
      
			return '<a href="tel:+' . digitOnly($m[1]) . ';ext=' . $m[2] . '">' . $phone . '</a>';
		} else {
			return '<a href="tel:+' . digitOnly($phone) . '">' . $phone . '</a>';
		}
	}
}

if (! empty($argv[1])) {
	echo getPhoneLink($argv[1]) . PHP_EOL;
} else {
	echo 'Script usage: php ' . $argv[1] . ' you@email.com' . PHP_EOL;
}
