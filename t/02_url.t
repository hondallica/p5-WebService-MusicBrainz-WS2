use strict;
use Test::More 0.98;
use WebService::MusicBrainz::WS2;


my $musicbrainz = new WebService::MusicBrainz::WS2;

is $musicbrainz->url, 'http://musicbrainz.org/ws/2/', 'Default URL';

$musicbrainz->url->scheme('https');
is $musicbrainz->url, 'https://musicbrainz.org/ws/2/', 'Change scheme';

$musicbrainz->url->path('/ws/3/');
is $musicbrainz->url, 'https://musicbrainz.org/ws/3/', 'Change path(API version)';

done_testing;

