<?php

/**
 * Return string suffix depend on amount
 * @param int $amount
 * @param string $singular
 * @param string $plural
 */
function plural($amount, $singular = '', $plural = 's')
{
    if ( $amount === 1 ) {
        return $singular;
    }
    return $plural;
}


$shavsanaBirthday = '01/07/2020';
$tz  = new DateTimeZone('Europe/Kiev');
$ageYears = DateTime::createFromFormat('d/m/Y', $shavsanaBirthday, $tz)
     ->diff(new DateTime('now', $tz))
     ->y;
$ageMonths = DateTime::createFromFormat('d/m/Y', $shavsanaBirthday, $tz)
     ->diff(new DateTime('now', $tz))
     ->m;

echo 'Shavasana has ' . $ageYears . ' year' . plural($ageYears, '', 's') . ' and ' . $ageMonths . ' month' . plural($ageMonths, '', 's') . '.' . PHP_EOL;
