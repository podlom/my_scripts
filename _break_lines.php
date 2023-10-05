<?php

/**
 * This script breaks long sentences to two most possible 
 * equal parts not breaking words
 *
 * php version 8.0+
 *
 * @category Text_Utilities
 * @package  Equal_Sentence_Line_Splitter
 * @author   Taras Shkodenko <taras@shkodenko.com>
 * @link     https://www.shkodenko.com/
 * @license  https://www.gnu.org/licenses/gpl-3.0.txt GNU/GPLv3
 */
 
// Check if the input file exists
$inputFile = "_long_lines_file_name.txt";


/**
 * This function breaks a line into two parts, 
 * aiming for equal number of characters, without breaking words
 *
 * @param string $line The line to split
 */
function breakLineEqually(string $line): array
{
    $length = strlen($line);
    $mid = intdiv($length, 2);

    $spaceBefore = strrpos($line, ' ', $mid - $length);
    $spaceAfter = strpos($line, ' ', $mid);

    if ($spaceBefore === false && $spaceAfter === false) {
        // No spaces in the string
        return [$line, ''];
    }

    if ($spaceBefore === false) {
        $breakPoint = $spaceAfter;
    } elseif ($spaceAfter === false) {
        $breakPoint = $spaceBefore;
    } else {
        // Choose the closest space to the middle
        $breakPoint = ($mid - $spaceBefore < $spaceAfter - $mid) ? 
            $spaceBefore : $spaceAfter;
    }

    $part1 = trim(substr($line, 0, $breakPoint));
    $part2 = trim(substr($line, $breakPoint));

    return [$part1, $part2];
}

if (!file_exists($inputFile)) {
    echo "The file " . $inputFile . " does not exist.\n";
    exit(1);
}

// Read the file line by line
$lines = file($inputFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
if ($lines === false) {
    echo "An error occurred while reading the file.\n";
    exit(1);
}

// Process each line
foreach ($lines as $line) {
    list($part1, $part2) = breakLineEqually($line);
    echo $part1 . "\t" . $part2 . "\n";
}
