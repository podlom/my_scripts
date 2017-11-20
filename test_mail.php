<?php

$emailTo = 'your@email.com';
$emailSubject = 'Testing mail on ' . php_uname();
$emailMessage = 'This is a Test ' . date('Y-m-d H:i:s');

// create email headers
$emailHeaders = 'From: www-data@from.com' . "\r\n" .
	'Reply-To: www-data@from.com' . "\r\n" .
	'X-Mailer: PHP/' . phpversion();
		   
$result = mail($emailTo, $emailSubject, $emailMessage, $emailHeaders);

if ($result) {
	echo 'Mail accepted for delivery ';
} else {
	echo 'Error: test mail unsuccessful... ';
}
