#!/usr/bin/perl
  
# Modules used
use strict;
use warnings;

my $sourceTradosFile=shift;
my $sourceFile="trados-source.txt";
my $targetFile="trados-target.txt";

open (FILE, "<$sourceTradosFile");
my @tradosSourceXML=<FILE>;
#chomp $LastAD;
close(FILE);

my $lineCounter=0;
#while (<FILE>) {
#while ($tradosSourceXML) {
foreach (@tradosSourceXML) {
    $lineCounter++;
    #push @LineStack, $_ ;
    print "Reading line: $lineCounter: $_\n";
}
print "Processed lines: $lineCounter\n";


