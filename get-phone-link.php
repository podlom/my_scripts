<?php

/**
 * @package global functions
 * @author Taras Shkodenko <taras@shkodenko.com>
 *
 * @see https://github.com/php-fig/fig-standards/blob/master/proposed/phpdoc.md for more PSR-5: PHPDoc
 *
 * Get phone link PHP cli script
 * Usage: php get-phone-link.php "+38 (067) 446-42-12"
 */

/**
 * Filter input string and return digits only
 *
 * @param string input string
 *
 * @return string
 */
function digitOnly($str) {
	if (!empty($str)) {
		return preg_replace('/[^0-9]/', '', $str);
	}
}

/**
 * Get phone link from phone number
 *
 * @param string phone number
 *
 * @return string
 */
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
	echo 'Script usage: php ' . $argv[1] . ' "+380 (67) 446-42-12"' . PHP_EOL;
}
