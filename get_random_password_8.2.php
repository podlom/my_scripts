<?php

/*
 * Random passwords generator
 *
 * Generate random passwords based on given Linux dictionary using version PHP 8.2 or newer
 * 
 *
 * @author Shkodenko V. Taras (taras -at- shkodenko.com)
 *
 * @version PHP 8.2.* or newer
 */

date_default_timezone_set('UTC');

/* Default password length */
$iPasswdLen = 15;

if( isset($argv[1]) && (strlen($argv[1]) > 0) ) {
	$iUserPasswdLen = intval($argv[1]);
	if ($iUserPasswdLen > 0) {
		echo "Random password ({$iUserPasswdLen}) is: " . getRandomPasswd($iUserPasswdLen) . PHP_EOL;	
		exit;
	}
}
echo "Random password ({$iPasswdLen}) is: " . getRandomPasswd($iPasswdLen) . PHP_EOL;
exit;


function getRandomArrayValue($a) {
	$k = array_rand($a);
	$v = $a[$k];
	return $v;
}

function getRandomChar() {
	$chars = array_merge(
		range('0', '9'),
		['&', '*', '!', '.', ',', '^', '~', '#', '?', '(', ')', '[', ']', '-', '_']
	);
    $r = new Random\Randomizer();
    $key = $r->getInt(0, count($chars));
    $shuffledArray = $r->shuffleBytes(implode('', $chars));
    if (isset($shuffledArray[$key])) {
        return $shuffledArray[$key];
    }
	return $shuffledArray[0];
}

function getRandomPasswd($passLen) {
	if ($passLen > 0) {
		// echo 'Generating password ' . $passLen . '...' . PHP_EOL;
	}
	$wordsList = dirname(__FILE__) . '/linux.words.txt';
	$aW1 = file($wordsList);
	$cn1 = count($aW1);
	if (is_array($aW1) && $cn1) {
		// echo 'Read ' . $cn1 . ' words from dictionary: ' . $wordsList . PHP_EOL;
		$pass = '';
		while(strlen($pass) < $passLen) {
			$r1 = getRandomArrayValue($aW1);
			// Fill In Password With Dictionary Words While It Is Not Long Enough
			$pass .= trim(ucfirst($r1));
			if (strlen($pass) > $passLen) {
				$pass = substr($pass, 0, $passLen);
			}
		}
		//
		// [ add random character password hardening #1
		$r2 = rand(1, $passLen);
		$pass1 = substr($pass, 0, $r2);
		$pass1 .= getRandomChar();
		$pass1 .= substr($pass, $r2 + 1, $passLen);
		// ]
		//
		// [ add random character password hardening #2
		$fR2 = 0;
		$r3 = rand(1, $passLen);
		while (! $fR2) {
			if ($r3 == $r2) {
				$r3 = rand(1, $passLen);
			} else {
				$fR2 = 1;
			}
		}
		$pass2 = substr($pass1, 0, $r3);
		$pass2 .= getRandomChar();
		$pass2 .= substr($pass1, $r3 + 1, $passLen);
		// ]
		//
		// [ add random character password hardening #3
		$fR3 = 0;
		$r4 = rand(1, $passLen);
		while (! $fR3) {
			if (
				($r4 == $r3) ||
				($r4 == $r2)
			) {
				$r4 = rand(1, $passLen);
			} else {
				$fR3 = 1;
			}
		}
		$pass3 = substr($pass2, 0, $r4);
		$pass3 .= getRandomChar();
		$pass3 .= substr($pass2, $r4 + 1, $passLen);
		// ]
		return $pass3;
	}
	return 'Error generating random password!' . PHP_EOL;
}
