<?php


function average(...$numbers) {
    // Перевірка, чи передано хоча б одне число
    if (count($numbers) === 0) {
        return 0;
    }

    // Сума всіх чисел
    $sum = array_sum($numbers);

    // Кількість чисел
    $count = count($numbers);

    // Середнє значення
    $average = $sum / $count;

    return $average;
}

// Приклад використання
$numbers = [10, 15];
echo "Середнє значення: " . average(...$numbers) . PHP_EOL; // Виведе 15
