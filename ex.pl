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
my $tokenCounter=0;
#while (<FILE>) {
#while ($tradosSourceXML) {
foreach (@tradosSourceXML) {
#<source><g id="7">PESTICIDE EMULSION CONCENTRATES CONTAINING PETROLEUM DERIVED OILS AND METHODS OF USE</g></source>
#<seg-source><g id="7"><mrk mtype="seg" mid="1">PESTICIDE EMULSION CONCENTRATES CONTAINING PETROLEUM DERIVED OILS AND METHODS OF USE</mrk></g></seg-source>
#<target><g id="7"><mrk mtype="seg" mid="1">EMULZNÍ KONCENTRÁTY PESTICIDŮ OBSAHUJÍCÍ  ROPNÉ OLEJE A ZPŮSOBY POUŽITÍ</mrk></g></target>

    while($_ =~ /<source>(<g id="\w+">)+(.*?)(<\/g>)+<\/source>(.*?)<target>(<g id="\w+">)+<mrk mtype="seg" mid="(\w+)">(.*?)<\/mrk>(<\/g>)+<\/target>/g) {
            $tokenCounter++;
            print "SOURCE ($tokenCounter): id=$6: $2\n";
            print "TARGET ($tokenCounter): id=$6: $7\n";
    }
    $lineCounter++;
}
print "Processed lines: $lineCounter\n";


