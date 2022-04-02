#!/usr/bin/perl

# Modules used
use strict;
use warnings;

my $sourceTradosFile=shift;
my $targetTradosFile=$sourceTradosFile . ".NEW";
my $sourceFile="trados-source.txt";
my $targetFile="trados-target.txt";

open (FILE, "<$sourceTradosFile");
my $tradosSourceXML=<FILE>;
#chomp $LastAD;
close(FILE);

open(FHS, $sourceFile) or die $!;
my @sourceFileLines=<FHS>;
close(FHS);

open(FHT, $targetFile) or die $!;
my @targetFileLines=<FHT>;
close(FHT);

my $lineCounter=0;
my $tokenCounter=0;
#while (<FILE>) {
#while ($tradosSourceXML) {

foreach $targetLine (@targetFileLines) {
    #<source><g id="7">PESTICIDE EMULSION CONCENTRATES CONTAINING PETROLEUM DERIVED OILS AND METHODS OF USE</g></source>
    #<seg-source><g id="7"><mrk mtype="seg" mid="1">PESTICIDE EMULSION CONCENTRATES CONTAINING PETROLEUM DERIVED OILS AND METHODS OF USE</mrk></g></seg-source>
    #<target><g id="7"><mrk mtype="seg" mid="1">EMULZNÍ KONCENTRÁTY PESTICIDŮ OBSAHUJÍCÍ  ROPNÉ OLEJE A ZPŮSOBY POUŽITÍ</mrk></g></target>


    my $sourceLine = shift(@sourceFileLines);

    $lineCounter++;

    chomp $targetLine;
    chomp $sourceLine;

    my $targetID;
    my $targetText;
    my $sourceID;
    my $sourceText;

    if ($targetLine =~ /^XID=(\w+):(.*)$/g) {
        my $targetID = $1;
        my $targetText = $2;
    }
    else {
        print "CAN NOT PARSE TARGET LINE: $targetLine\n";
        next;
    }

    if ($sourceLine =~ /^XID=(\w+):(.*)$/g) {
        my $sourceID = $1;
        my $sourceText = $2;
    }
    else {
        print "CAN NOT PARSE SOURCE LINE: $sourceLine\n";
        next;
    }

    die "Source vs Target file mismatch!!!\n" if ($sourceID != $targetID);

    print "--------------------------------------------------------------------------------\n";
    print "XID=$targetID    line=$lineCounter\n";
    print "SOURCE=$sourceText\n";
    print "TARGET=$targetText\n";
}



