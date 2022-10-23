#!/usr/bin/perl

# Modules used
use strict;
use warnings;

my $deeplAuthenticationKey = "a11c47a8-f648-b6bd-be7a-21d3f3255a60:fx";

my $sourceFileName="trados-source.txt";
my $targetFileName="trados-translated.txt";
my $translatedText;

open (FILE, "<$sourceFileName");
my @tradosSourceFileText=<FILE>;
close(FILE);

open(FHT, '>', $targetFileName) or die $!;

my $counter = 0;


foreach my $sourceLine (@tradosSourceFileText) {
    my $sourceID;
    my $sourceText;
    if ($sourceLine =~ /^XID=(\w+):(.*)$/g) {
        $sourceID = $1;
        $sourceText = $2;
    }
    else {
        die "CAN NOT PARSE SOURCE LINE: $sourceLine\n";
    }

    $counter++;

    my $deeplQuery = "curl -X POST 'https://api-free.deepl.com/v2/translate' -H 'Authorization: DeepL-Auth-Key " . $deeplAuthenticationKey . "' -d 'text=" . $sourceText . "' -d 'target_lang=CS'";
    print "QUERY: $deeplQuery\n";
    my $deeplQueryResponse = system $deeplQuery;

    if ($deeplQueryResponse =~ /\"text\":\"(.*)([^\\])\"$/g) {
        $translatedText = $1 . $2;
    }
    else {
        die "CAN NOT PARSE TRANSLATED RESPONSE: $deeplQueryResponse\n";
    }

    print FHT "XID=$sourceID:$translatedText";

}
















