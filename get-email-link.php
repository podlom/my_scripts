<?php

/**
 * Get email link PHP cli script
 * Usage: php get-email-link.php you@email.com
 */

function getEmailLink($email) {
	if (!empty($email)) {
		return '<a href="mailto:' . $email . '">' . $email . '</a>';
	}
}

if (! empty($argv[1])) {
	echo getEmailLink($argv[1]) . PHP_EOL;
} else {
	echo 'Script usage: php ' . $argv[1] . ' you@email.com' . PHP_EOL;
}
