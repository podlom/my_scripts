<?php

if (empty($argv)
        || count($argv) < 2
) {
    die('Script usage: php ' . $argv[0] . ' "folder_to_grep"' . PHP_EOL);
}

// echo print_r($argv, 1) . PHP_EOL;

global $reportFile;
$reportFile = 'grep.log';

function grepInFile($file, $str) {
    $retInfo = $repInfo = '';
    if (file_exists($file)) {
        $f1 = file($file);
        if (!empty($f1)) {
            foreach ($f1 as $ln1 => $lv1) {
                if (preg_match('|'. $str .'|', $lv1)) {
                    $strRep   = 'Found ' . $str . 
                        ' in file ' . $file . 
                        ' on line #' . $ln1 . ':' . PHP_EOL . 
                        $lv1 . PHP_EOL;
                    $retInfo .= $strRep;
                    $repInfo .= $strRep;
                }
            }
        }
    } else {
        $retInfo = 'Error: file ' . $file . ' was not found!' . PHP_EOL;
    }
    
    if (!empty($repInfo)) {
        global $reportFile;
        file_put_contents($reportFile, $repInfo, FILE_APPEND);
    }
    
    return $retInfo;
}

function checkDir($dir) {
    $outData = '';
    $outData .= 'Checking directory: ' . $dir . ' ...' . PHP_EOL;
    if (is_dir($dir)) {
        if ($dh = opendir($dir)) {
            while (($file = readdir($dh)) !== false) {
                if ($file !== '.' && $file !== '..') {
                    $outData .= "filename: $file : filetype: " . filetype($dir . DIRECTORY_SEPARATOR . $file) . "\n";
                    if ('dir' == filetype($dir . DIRECTORY_SEPARATOR . $file)) {
                        $outData .= checkDir($dir . DIRECTORY_SEPARATOR . $file);
                    }
                    if ('file' == filetype($dir . DIRECTORY_SEPARATOR . $file)) {
                        $paIn = pathinfo($dir . DIRECTORY_SEPARATOR . $file);
                        if (isset($paIn['extension'])
                            && $paIn['extension'] == 'php'
                        ) {
                            $outData .= grepInFile($dir . DIRECTORY_SEPARATOR . $file, 'setcookie');
                        }
                    }
                }        
            }
            closedir($dh);
        }
    } else {
        $outData .= 'Error: ' . $dir . ' is not a directory.' . PHP_EOL;
    }
    
    return $outData;
}


// $dir = escapeshellarg($argv[1]);
$dir = $argv[1];
$dirContents = checkDir($dir);
echo $dirContents;
