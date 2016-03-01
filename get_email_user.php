<?php

/*
 * Email account generator
 *
 * Generate user email account information based on user name
 * 
 *
 * @author Shkodenko V. Taras (taras -at- shkodenko.com)
 *
 */

date_default_timezone_set('UTC');

global $iPasswdLen;
/* Default password length */
$iPasswdLen = 15;

if ( isset($argv[1])
    && (strlen($argv[1]) > 0)
) {
    get_email_user($argv[1]);
} else {
    echo "Script usage: php -f " . $argv[0] . " [Firstname Lastname]\n";
}

exit;

function get_random_password2($length = 15) {
    $maximum_double_chars_in_pw = 0;
    if ($length >= 76) {
        $length = 75;
        echo "Maximum allowed password length set to: " . $length . PHP_EOL;
    }
    $maximum_double_chars_in_pw = intval($length / 10);
    /* echo '$maximum_double_chars_in_pw: ' . $maximum_double_chars_in_pw . PHP_EOL; */
    $chars = array(
        range('a', 'z'),
        range('A', 'Z'),
        range('0', '9'),
        array('&', '*', '!', '.', ',', '^', '~', '#', '?', '(', ')', '[', ']', '-', '_'),
    );
    if (! $length) {
        $length = rand(8, 12);
    }
    $password = "";
    while (strlen($password) != $length) {
    	$chars_set = $chars[rand(0, count($chars)-1)];
    	$char = $chars_set[rand(0, count($chars_set)-1)];
    	if (strlen($password) > 0) {
    		/* echo '$password: ' . $password . '; $maximum_double_chars_in_pw: ' . $maximum_double_chars_in_pw . '; $length: ' . $length . PHP_EOL; */
		$p = strpos($password, $char);
		if ($p === false) {
			$password .= $char;	
                } else {
                    -- $maximum_double_chars_in_pw;
                    if ($maximum_double_chars_in_pw > 0) {
                    	$password .= $char;
                    }
                }
	} else {
            $password .= $char;
        }
    }
    return $password;
}

function getRandomArrayValue($a) {
	$k = array_rand($a);
	$v = $a[$k];
	return $v;
}

function getRandomChar() {
	$chars = array_merge(
		range('0', '9'),
		array('&', '*', '!', '.', ',', '^', '~', '#', '?', '(', ')', '[', ']', '-', '_')
	);
	return getRandomArrayValue($chars);
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
		while (strlen($pass) < $passLen) {
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
			if ( ($r4 == $r3)
                            || ($r4 == $r2)
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

function getIP() {
    $aKeys = array('HTTP_CLIENT_IP', 'HTTP_X_FORWARDED_FOR', 'HTTP_X_FORWARDED', 'HTTP_X_CLUSTER_CLIENT_IP', 'HTTP_FORWARDED_FOR', 'HTTP_FORWARDED', 'REMOTE_ADDR');
    foreach ($aKeys as $key) {
        if (array_key_exists($key, $_SERVER) === true) {
            foreach (explode(',', $_SERVER[$key]) as $ip) {
                $ip = trim($ip); // just to be safe
                if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE) !== false) {
                    return $ip;
                }
            }
        }
    }
}

function get_email_user($user_name) {
	global $iPasswdLen;
	$email_password = getRandomPasswd($iPasswdLen);

	$email_user_name1 = trim($user_name);
	$email_user_name2 = strtolower($email_user_name1);
	$email_user_name4 = str_replace(' ', '.', $email_user_name2);
	$a_email_usr_part = explode(' ', $email_user_name2);
	$email_user_name2 = substr($a_email_usr_part[0], 0, 1) . ' ' . $a_email_usr_part[1];
	$email_user_name3 = str_replace(' ', '.', $email_user_name2);

$msg = <<<EOM
{$email_user_name1}

Login: {$email_user_name3}@shkodenko.com
Password: {$email_password}

POP3 Server: mail.shkodenko.com
Port: 110
Connection security: STARTTLS

SMTP Server: mail.shkodenko.com
Port: 587
Authentication method: Normal password
Connection security: STARTTLS

Webmail URL: https://webmail.shkodenko.com

EOM;

	// echo $msg;
	if (! plm_write_file( $email_user_name4, $msg )) {
		echo __FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' Error: can`t write data below to log file:' . PHP_EOL;
		echo $msg;
	}

}

function plm_write_file( $email_user_name, $file_content ) {

	$date_str = date('-Y-m-d');
	$path_to_file = '/home/taras/Documents/shkodenko.com/email-accounts/';
	$full_file_name = $path_to_file . escapeshellcmd($email_user_name) . $date_str . '.txt';
	$file_zip_name = './' . escapeshellcmd($email_user_name) . $date_str . '.zip';
	$file_txt_name = './' . escapeshellcmd($email_user_name) . $date_str . '.txt';

	system('touch ' . $full_file_name);
	if( !is_writable($full_file_name) ) {
         echo __FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' Error: file (' . $full_file_name . ') is not writable!' . PHP_EOL;
		 echo __FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' Log file output: ' . PHP_EOL . $file_content . PHP_EOL;
         return false;
	}
	if( !$fh1 = fopen($full_file_name, 'w') ) {
         echo __FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' Error: can`t open file (' . $full_file_name . ')' . PHP_EOL;
		 echo __FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' Log file output: ' . PHP_EOL . $file_content . PHP_EOL;
         return false;
    }
    if( fwrite($fh1, $file_content) === FALSE ) {
        echo __FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' Error: can`t write to file (' . $full_file_name . ')' . PHP_EOL;
		echo __FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' Log file output: ' . PHP_EOL . $file_content . PHP_EOL;
    }
    fclose($fh1);

    echo __FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' File is written: ' . PHP_EOL . 
    	$full_file_name . PHP_EOL . ' Run commands: ' . PHP_EOL . 
    	'cd ' . $path_to_file . PHP_EOL . 
    	'zip -e ' . $file_zip_name . ' ' . $file_txt_name . PHP_EOL . 
    	' ... to get password protected zip archive.' . PHP_EOL;

    return true;
}
