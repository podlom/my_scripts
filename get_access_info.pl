#!/usr/bin/perl 
#===============================================================================
#
#         FILE: get_access_info.pl 
#
#        USAGE: ./get_access_info.pl
#
#  DESCRIPTION: Generate access information for (sub)domain(s) passed as argument(s)
#
#      OPTIONS: (Sub)Domain name(s)
# REQUIREMENTS: Perl 5 & Socket module
#         BUGS: None found
#        NOTES: ---
#       AUTHOR: Taras Shkodenko (taras [at] shkodenko [dot] com), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 05/07/2013 07:15:59 PM
#     REVISION: 3
#===============================================================================

use strict;
use warnings;
use Socket;

sub rnd_str
{
    join '', @_[ map{ rand @_ } 1 .. shift ]
}

sub get_pass
{
    return rnd_str shift, 'a'..'z', 'A'..'Z', 0..9, '-', '_', '.', ',', '#', '@', '$', ';', ':', '?', '|', '/', '\\', '{', '}', '(', ')', '[', ']';
}

sub get_ftp_pass
{
	return get_pass(22);
}

sub get_db_pass
{
	return get_pass(15);
}

sub cnt_dom_parts
{
	my $domain_name = shift;
	my $i = 0;
    my @dom = split('\.', $domain_name);
    for my $d_part (@dom) {
        ++ $i;
    }
	return $i;
}

sub get_suffix
{
	my $domain_name = shift;
	my $ftp_suffix = 'user';
	my $dp = cnt_dom_parts($domain_name);

	if( $dp > 2 ) {
		my @dom = split('\.', $domain_name);
		$ftp_suffix = substr($dom[1], 0, 2) . '_' . $dom[0];
		if( length($ftp_suffix) > 15 ) {
			$ftp_suffix = substr($ftp_suffix, 0, 15);
		}
	} else {
		$domain_name =~ s/[.]//g;
		my $len = length($domain_name);
		if( $len > 0 ) {
			if( $len > 12 ) {
				$ftp_suffix = substr($domain_name, 0, 12);
			} else {
				$ftp_suffix = $domain_name;
			}
		}
	}
	return $ftp_suffix;
}

sub get_ftp_user
{
    my $domain_name = shift;
	my $ftp_user = 'ftp_' . get_suffix($domain_name);
	return $ftp_user;
}

sub filter_mysql_str
{
    #
	# @see: http://dev.mysql.com/doc/refman/5.0/en/identifiers.html
    # Permitted characters in unquoted identifiers:
    # ASCII: [0-9,a-z,A-Z$_] (basic Latin letters, digits 0-9, dollar, underscore)
    #
	my $str = shift;
	$str =~ s/[^a-zA-z0-9_]//g;
	return $str;
}

sub get_db_name
{
	my $domain_name = shift;
	my $db_name = get_suffix($domain_name) . '_db';
	$db_name = filter_mysql_str($db_name);
	return $db_name;
}

sub get_db_user
{
	my $domain_name = shift;
	my $db_user = get_suffix($domain_name) . '_u';
	$db_user = filter_mysql_str($db_user);
	return $db_user;
}

sub generate_access_information
{
	my $domain_name = shift;

	print 'Access information for: ' . $domain_name . "\n";
	my $packed_ip = gethostbyname($domain_name);
	if (defined $packed_ip) {
        my $ip_address = inet_ntoa($packed_ip);
		print 'IP Address: ' . $ip_address . "\n";

    }

    print "\n";
    # FTP Access
    print "\n";
    print '[FTP Access]' . "\n";
    print 'Username: ' . get_ftp_user($domain_name) . "\n";
    print 'Password: ' . get_ftp_pass . "\n\n";
    print "\n";
    print '[MySQL Database]' . "\n";
    print 'Host: localhost' . "\n";
    print 'Name: ' . get_db_name($domain_name) . "\n";
    print 'Username: ' . get_db_user($domain_name) . "\n";
    print 'Password: ' . get_db_pass . "\n\n";

}

my $n = 0;
for my $arg (@ARGV) {
	generate_access_information($arg);
	++ $n;
}

if ( 0 == $n ) {
	print 'Give task number to get URL.' . "\n";
}

#                                                                                                                                                                                                              
# vim:ts=4:sts=4:sw=4
