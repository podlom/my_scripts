#!/usr/bin/env perl

use strict;
use warnings;

sub print_cur_date()
{
        my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
        my $curDate = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
        return $curDate;
}

print 'Started work at: ' . print_cur_date() . "\n";

my $numStoreBackups = 12;
#
my $backupsDir = '/root/backups';
#
chdir $backupsDir;
#
my $dirPat = "_pharm_backup_*";
#
my @files = glob("$dirPat");
#
print 'All backup directories: ' . "\n";
#
foreach my $dir (@files) {
        print "$dir \n";
}
#
if ($#files > $numStoreBackups) {
        my $remBackups = $#files - $numStoreBackups;
        my @removeDirs = @files[0 .. $remBackups];
        foreach my $rDir (@removeDirs) {
                my $fullRemoveDir = "$backupsDir/$rDir";
                print "Started to remove directory $fullRemoveDir at " .  print_cur_date() . "\n";
                my $result = system("rm -rf $fullRemoveDir");
                print "Finished to remove directory $fullRemoveDir at " .  print_cur_date() . " Result: $result \n";

        }
} else {
        print 'Number of backups: ' . $#files . ' is less than ' . $numStoreBackups . "\n";
}
