#!/usr/bin/perl
  
# Modules used
use strict;
use warnings;

my $sourceFile="trados-target-split-translated.txt";
my $sourceCzechFile="trados-target-czech.txt";
my $targetFile="trados-target.txt";

open (FILE, "<$sourceFile");
my @tradosSourceText=<FILE>;
close(FILE);

open (FILE, "<$sourceCzechFile");
my @tradosSourceCzechText=<FILE>;
close(FILE);

open(FHT, '>', $targetFile) or die $!;

my $translatedLine;
my $translatedLineID;
my $origLine;
my $origLineID;

if (@tradosSourceText) {
    $translatedLine =  shift @tradosSourceText;
    if ($translatedLine =~ /^XID=(\w+):(.*)$/g) {
        $translatedLineID = $1;
    } else { die "$sourceFile is corrupted on: $translatedLine" }
} else {    $translatedLineID = 10000000}



if (@tradosSourceCzechText) {
    $origLine =  shift @tradosSourceCzechText;
    if ($origLine =~ /^XID=(\w+):(.*)$/g) {
        $origLineID = $1;
    } else {die "$sourceCzechFile is corrupted on: $origLine"}
} else {$origLineID = 10000000}

while ( @tradosSourceText || @tradosSourceCzechText) {
    die "XID match during merge of line $translatedLineID" if ($translatedLineID == $origLineID);
    if ($translatedLineID < $origLineID) {
        print FHT $translatedLine;
        print "Translated: $translatedLine";
        if (@tradosSourceText) {
            $translatedLine = shift @tradosSourceText;
            if ($translatedLine =~ /^XID=(\w+):(.*)$/g) {
                $translatedLineID = $1;
            }
            else{die "Translated File is corrupted on: $translatedLine"}
        }
        else {$translatedLineID = 10000000}

    }
    else {
        print FHT $origLine;
        print "Czech     : $origLine";
        if (@tradosSourceCzechText) {
            $origLine = shift @tradosSourceCzechText;
            if ($origLine =~ /^XID=(\w+):(.*)$/g) {
                $origLineID = $1;
            }
            else { die "Czech File is corrupted on: $origLine"}
        }
        else {$origLineID = 10000000}
    }
}

if ($translatedLineID < $origLineID) {
    print FHT $translatedLine;
    print "Translated: $translatedLine";
    if ($origLineID < 10000000) {
        print "Czech     : $origLine";
    }
}
else {
    print FHT $origLine;
    print "Czech     : $origLine";
    if ($translatedLineID < 10000000) {
        print "Translated: $translatedLine";
    }

}



close FHT;
