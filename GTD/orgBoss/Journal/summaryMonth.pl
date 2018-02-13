#!/usr/bin/env perl
#===============================================================================
#
#         FILE: summaryMonth.pl
#
#        USAGE: ./summaryMonth.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 2018/2/21 0:10:18
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

#print "$_\n" foreach <"2017*">;  00 express  -
my	$CollectFile_file_name = '2017100011';# output file name



open  my $CollectFile, '>', $CollectFile_file_name
    or die  "$0 : failed to open  output file '$CollectFile_file_name' : $!\n";

foreach my $file ( <"20171[01]*"> ) {

    print $CollectFile "## $file -----------------------------------\n";

    
    my	$IntoFile_file_name = $file;#  input file name

    open  my $IntoFile, '<', $IntoFile_file_name
        or die  "$0 : failed to open  input file '$IntoFile_file_name' : $!\n";



    while ( <$IntoFile> ) {
        print $CollectFile "$_";
    }
    ##    print $CollectFile <$IntoFile>;
    # # while ( <$file> ) {
    #     print "$_\n";
    # }
    close  $IntoFile
        or warn "$0 : failed to close input file '$IntoFile_file_name' : $!\n";


}
close  $CollectFile
    or warn "$0 : failed to close output file '$CollectFile_file_name' : $!\n";


