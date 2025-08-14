<?php

/**
 * Random password generator based on a given text file words dictionary
 *
 * php version 8.0+
 *
 * @category Security_Utilities
 * @package  Random_Words_Password_Generator
 * @author   Taras Shkodenko <taras.shkodenko@gmail.com>
 * @link     https://www.shkodenko.com/
 * @license  https://www.gnu.org/licenses/gpl-3.0.txt GNU/GPLv3
 */

$options = getopt("l:f:", ["length:", "file:"]);

// Defaults
$length = isset($options['l']) ? $options['l'] : (isset($options['length']) ? $options['length'] : 4);
$filePath = isset($options['f']) ? $options['f'] : (isset($options['file']) ? $options['file'] : "linux.words.txt");

// Validate length
if (!ctype_digit(strval($length)) || intval($length) <= 1) {
    fwrite(STDERR, "Error: Length must be an unsigned integer greater than 1.\n");
    exit(1);
}
$length = intval($length);

// Check file existence
if (!file_exists($filePath)) {
    fwrite(STDERR, "Error: File not found: {$filePath}\n");
    exit(1);
}

// Read words
$words = file($filePath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

if (count($words) < $length) {
    fwrite(STDERR, "Error: File contains only " . count($words) . " words, but {$length} requested.\n");
    exit(1);
}

// Pick random words
$randomKeys = array_rand($words, $length);
if (!is_array($randomKeys)) {
    $randomKeys = [$randomKeys];
}

$passwordWords = array_map(fn($key) => $words[$key], $randomKeys);
echo implode(' ', $passwordWords) . PHP_EOL;
