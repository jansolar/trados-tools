#!/usr/bin/perl
  
# Modules used
use strict;
use warnings;

my $sourceFile="trados-source.txt";
my $targetFile="trados-target.txt";

open (FILE, "<$sourceFile");
my @sourceText=<FILE>;
close(FILE);

open (FILE, "<$targetFile");
my @targetText=<FILE>;
close(FILE);

foreach (@targetText) {
    if ($_ =~ /\& (\w+);/g) {
        print "Error: >>& $1;<< in: $_";
    }
    if ($_ =~ /\&\&/g) {
        print "Warning: Double & in: $_";
    }
    if ($_ =~ /\< g id/g) {
        print "Warning: Wrong tag start: < g id :  $_";
    }
    if ($_ =~ /\<\!g id/g) {
        print "Warning: Wrong tag start: <!g id :  $_";
    }

    if ($_ =~ /\.g id/g) {
        print "Warning: Wrong tag start: .g id :  $_";
    }


}

foreach my $targetTextLine (@targetText) {
    my $sourceTextLine = shift @sourceText;
    my $targetCount = $targetTextLine =~ tr/\///;
    my $sourceCount = $sourceTextLine =~ tr/\///;
    if ( $targetCount != $sourceCount) {
        print "\nNot matching / tags:\n";
        print $sourceTextLine;
        print $targetTextLine;
    }

    $targetCount = $targetTextLine =~ tr/\<//;
    $sourceCount = $sourceTextLine =~ tr/\<//;
    if ( $targetCount != $sourceCount) {
        print "\nNot matching < tags:\n";
        print $sourceTextLine;
        print $targetTextLine;
    }


    $targetCount = $targetTextLine =~ tr/\>//;
    $sourceCount = $sourceTextLine =~ tr/\>//;
    if ( $targetCount != $sourceCount) {
        print "\nNot matching > tags:\n";
        print $sourceTextLine;
        print $targetTextLine;
    }


}