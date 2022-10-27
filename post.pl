#use strict;
use warnings;

use HTTP::Request ();
use JSON::MaybeXS qw(encode_json decode_json is_bool); # functions only
use LWP::UserAgent;

my $deeplAuthenticationKey = "a11c47a8-f648-b6bd-be7a-21d3f3255a60:fx";
my $url = 'https://api-free.deepl.com/v2/translate';
#my $url = 'https://172.65.205.19/v2/translate';

my $header = ['Authorization' => 'DeepL-Auth-Key ' . $deeplAuthenticationKey, 'Content-Type' => 'application/x-www-form-urlencoded'];
my $data = 'text=Hello world&target_lang=CS';

#my $encoded_data = encode_json($data);



my $req = HTTP::Request->new('POST', $url, $header, $data);

my $postMessage = $req->decoded_content;
print "Post message: $postMessage\n";
my $ua = LWP::UserAgent->new;
my $resp = $ua->request($req);
print "start...\n";
print "HTTP error code: ", $resp->code, "\n";
my $message = $resp->decoded_content;
print $message;
print "\n";
print "end...\n";
