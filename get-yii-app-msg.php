<?php

/**
 * Get Yii:t app message translation
 * Usage: php get-yii-app-msg.php "Message to translate from"
 */

function getYiiApp($text) {
	if (!empty($text)) {
		return "<?= Yii::t('app', '" . str_replace("'", '&apos;', $text) . "') ?>";
	}
}

if (! empty($argv[1])) {
	echo getYiiApp($argv[1]) . PHP_EOL;
} else {
	echo 'Script usage: php ' . $argv[1] . ' message' . PHP_EOL;
}
