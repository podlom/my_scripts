#!/bin/bash

die()
{
  echo >&2 "$1"
  exit 1
}

test_php_ver()
{
  v=`php -r 'echo PHP_VERSION;'`
  r=$(php -r 'echo version_compare(PHP_VERSION, "5.6.19") >= 0 ? 1 : 0;')
  [ $r -eq 1 ] || die "Invalid php version ${v} expected PHP version greater or equal 5.6.19"
}

test_php_ver
