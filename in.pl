#!/usr/bin/perl


#<source><g id="7">PESTICIDE EMULSION CONCENTRATES CONTAINING PETROLEUM DERIVED OILS AND METHODS OF USE</g></source>
#<seg-source><g id="7"><mrk mtype="seg" mid="1">PESTICIDE EMULSION CONCENTRATES CONTAINING PETROLEUM DERIVED OILS AND METHODS OF USE</mrk></g></seg-source>
#<target><g id="7"><mrk mtype="seg" mid="1">EMULZNÍ KONCENTRÁTY PESTICIDŮ OBSAHUJÍCÍ  ROPNÉ OLEJE A ZPŮSOBY POUŽITÍ</mrk></g></target>

# Modules used
use strict;
use warnings;

my $sourceTradosFile=shift;
my $targetTradosFile=$sourceTradosFile . ".NEW";
#my $targetTradosFile="ENCSb_EP3065543 B1 word file_FullSpec_ExcAbsRTEHL_NoPM.docx.sdlxliff";
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




my $tradosSourceXMLNew = $tradosSourceXML;
while($tradosSourceXML =~ /<target>(.*?)<\/target>/g) {
    my $targetStringOrig = "<target>" . $1 . "</target>";
    my $targetString = $targetStringOrig;
    my $newTargetString = $targetStringOrig;
    while ($targetString =~ /<mrk mtype="seg" mid="(\w+)">(.*?)<\/mrk>/g) {
        my $patternID = $1;
        my $patternText = $2;

        my $targetLine = shift(@targetFileLines);
        my $sourceLine = shift(@sourceFileLines);

        chomp $targetLine;
        chomp $sourceLine;

        my $targetID;
        my $targetText;
        my $sourceID;
        my $sourceText;

        if ($targetLine =~ /^XID=(\w+):(.*)$/g) {
            $targetID = $1;
            $targetText = $2;
        }
        else {
            die "CAN NOT PARSE TARGET LINE: $targetLine\n";
        }

        if ($sourceLine =~ /^XID=(\w+):(.*)$/g) {
            $sourceID = $1;
            $sourceText = $2;
        }
        else {
            die "CAN NOT PARSE SOURCE LINE: $sourceLine\n";
        }

        die "Source vs Target file ID mismatch!!!\n" if ($sourceID != $targetID);
        die "Pattern vs Target file ID mismatch!!!\n" if ($patternID != $targetID);
        die "Pattern vs Source file text mismatch!!!\n" if ($patternText ne $sourceText);

        print "--------------------------------------------------------------------------------\n";
        print "XID=$targetID    line=$lineCounter\n";
        print "SOURCE=$sourceText\n";
        print "TARGET=$targetText\n";

        my $searchPattern='<mrk mtype="seg" mid="' . $patternID . '">' . $patternText . '</mrk>';
        my $replacePattern='<mrk mtype="seg" mid="' . $patternID . '">' . $targetText . '</mrk>';

        print "SOURCE PATTERN=$searchPattern\n";
        print "TARGET PATTERN=$replacePattern\n";

        #Ignore strings with tags!
        $newTargetString =~ s/\Q$searchPattern\E/$replacePattern/g unless $sourceText =~ /</;

        #$newTargetString =~ s/\Q$searchPattern\E/$replacePattern/g;

    }
    $tradosSourceXMLNew =~ s/\Q$targetStringOrig\E/$newTargetString/g;
}

open(FHT, '>', $targetTradosFile) or die $!;
print FHT $tradosSourceXMLNew;
close(FHT);






