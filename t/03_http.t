use strict;
use Test::More 0.98;
use WebService::MusicBrainz::WS2;


my $musicbrainz = new WebService::MusicBrainz::WS2;
isa_ok $musicbrainz->http, 'Furl::HTTP';

is $musicbrainz->http->{headers}[0], 'User-Agent';
like $musicbrainz->http->{headers}[1], qr|^WebService::MusicBrainz::WS2/|;
is $musicbrainz->http->{headers}[2], 'Accept-Encoding';
is $musicbrainz->http->{headers}[3], 'gzip';


done_testing;

