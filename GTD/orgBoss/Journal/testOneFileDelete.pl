#!/usr/bin/env perl
#===============================================================================
#
#         FILE: testOneFileDelete.pl
#
#        USAGE: ./testOneFileDelete.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Ye Zhao Liang (YZL), yezhaoliang@ncepu.edu.cn
# ORGANIZATION: NCEPU
#      VERSION: 1.0
#      CREATED: 2018/8/28 17:32:03
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;


my	$journal2018_file_name = '20171000112.org';		# output file name

open  my $journal2018, '<', $journal2018_file_name
    or die  "$0 : failed to open  output file '$journal2018_file_name' : $!\n";


my	$journalOut_file_name = 'outputTest.org';		# output file name

open  my $journalOut, '>', $journalOut_file_name
    or die  "$0 : failed to open  output file '$journalOut_file_name' : $!\n";

while ( <$journal2018> ) {
    
    if (/^\*\skeep/ ) {
        print tell $journal2018,"$_\n";
        seek($journal2018,(tell $journal2018)+150,0);
    }else{
        print $journalOut $_;
    }
}

close  $journal2018
    or warn "$0 : failed to close output file '$journal2018_file_name' : $!\n";
close  $journalOut
    or warn "$0 : failed to close output file '$journalOut_file_name' : $!\n";



