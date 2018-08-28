#!/usr/bin/env perl
#===============================================================================
#
#         FILE: testCollect.pl
#
#        USAGE: ./testCollect.pl  
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
#      CREATED: 2018/8/28 17:07:32
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;



my	$journalOne_file_name = '../OneJournal.org';		# output file name

open  my $journalOne, '>', $journalOne_file_name
    or die  "$0 : failed to open  output file '$journalOne_file_name' : $!\n";

#while ( glob("*") ) {
while ( <*> ) {

    my	$journalF_file_name = "$_";# input file name

    print "$_\n";
    open  my $journalF, '<', $journalF_file_name
        or die  "$0 : failed to open  input file '$journalF_file_name' : $!\n";

    print $journalOne "* $_\n";
    my  $lineNumber=1;
    while ( <$journalF> ) {
        if($lineNumber >8)
        {
            print $journalOne "$_\n";
        }
        $lineNumber=$lineNumber+1;
    }
    close  $journalF
        or warn "$0 : failed to close input file '$journalF_file_name' : $!\n";

}

close  $journalOne
    or warn "$0 : failed to close output file '$journalOne_file_name' : $!\n";


