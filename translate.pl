#!/usr/bin/perl

# Modules used
use strict;
use warnings;
use JSON::MaybeXS qw(encode_json decode_json is_bool); # functions only
use Data::Dumper;

my $deeplAuthenticationKey = "a11c47a8-f648-b6bd-be7a-21d3f3255a60:fx";

my $sourceFileName="trados-source.txt";
#my $sourceFileName="translate.txt";
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
    print "------------------------------------------------------------------------------------------\n";
    print "ID = $sourceID\n";
    $counter++;
    $sourceText =~ s/\"/\\\"/g;
    $sourceText =~ s/\&/%26/g;

    my $deeplQuery = "curl -X POST \"https://api-free.deepl.com/v2/translate\" -H \"Authorization: DeepL-Auth-Key " . $deeplAuthenticationKey . "\" -d \"text=" . $sourceText . "\" -d \"target_lang=CS\" -d \"source_lang=EN\"";
    print "QUERY: $deeplQuery\n";

    my $deeplQueryResponse = `$deeplQuery`;

    print "Response: $deeplQueryResponse\n";


    if ($deeplQueryResponse =~ /\"text\":\"(.*)([^\\])\"/g) {
    #if ($deeplQueryResponse =~ /text(.*)([^\\])/g) {
        $translatedText = $1 . $2;
        }
    else {
            die "CAN NOT PARSE TRANSLATED RESPONSE: $deeplQueryResponse\n";
    }

    $translatedText =~ s/\\\"/\"/g;
    $translatedText =~ s/\&\&/\&/g;
    $translatedText =~ s/\< g id/<g id/g;
    $translatedText =~ s/\<\.g id/<g id/g;
    $translatedText =~ s/\<\!g id/<g id/g;
    $translatedText =~ s/\& apos/\&apos/g;
    $translatedText =~ s/\& quot/\&quot/g;
    $translatedText =~ s/\& amp/&amp/g;
    print "------------------------------------------------------------------------------------------\n";
    print "Translated:$translatedText\n";
    print FHT "XID=$sourceID:$translatedText\n";

}
close(FHT);















