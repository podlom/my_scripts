#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use POSIX;

my $output = `/usr/sbin/lsof -i :80 | /bin/grep -c 'httpd'`; 

print strftime "%F %T ", localtime $^T;
print 'Number of http connections: ' . int($output) . "\n";

if (int($output) > 400) {
  my @http_restart_output = `/usr/local/apache/bin/apachectl -k restart`;
  # print strftime "%F %T", localtime $^T;
  for my $ln (@http_restart_output) {
    print $ln . "\n";
  }
  #
  if ($? == -1) {
    print "failed to execute: $!\n";
  } elsif ($? & 127) {
    printf "child died with signal %d, %s coredump\n", ($? & 127), ($? & 128) ? 'with' : 'without';
  } else {
    printf "child exited with value %d\n", $? >> 8;
  }
}
