#!/usr/bin/perl
  
# Modules used
use strict;
use warnings;

my $sourceFile="trados-target.txt";
my $sourceCzechFile="trados-target-czech.txt";
my $targetFile="trados-target-split.txt";

open (FILE, "<$sourceFile");
my @tradosSourceText=<FILE>;
close(FILE);

open (FILE, "<$sourceCzechFile");
my @tradosSourceCzechText=<FILE>;
close(FILE);

open(FHT, '>', $targetFile) or die $!;

my @tradosTargetCzechText = grep { my $element = $_; ! grep $_ eq $element, @tradosSourceCzechText } @tradosSourceText;

print FHT @tradosTargetCzechText;

close FHT;
