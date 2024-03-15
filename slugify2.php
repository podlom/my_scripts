<?php

/*
 * Slugify text including cyrillic letters to URL slug string
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 *
 */

function slugify(string $text, string $divider = '-')
{
    // Конвертуємо кирилицю у латиницю
    $string = transliterator_transliterate('Any-Latin; Latin-ASCII', $text);

    // Замінюємо всі символи, крім букв і цифр, на пробіли
    $string = preg_replace('/[^a-zA-Z0-9]/', ' ', $string);

    // Перетворюємо усі пробіли на дефіси
    $string = str_replace(' ', $divider, $string);

    // Перетворюємо рядок у нижній регістр
    $string = strtolower($string);

    // remove duplicate divider
    $string = preg_replace('~' . $divider . '+~', $divider, $string);

    // Повертаємо результат
    return $string;
}

if (isset($argv[1])
    && (strlen($argv[1]) > 0)
) {
    echo slugify($argv[1]) . PHP_EOL;
} else {
    echo "Script usage: php " . $argv[0] . " [Some Text To Slugify]\n";
}
