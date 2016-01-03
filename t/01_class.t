use strict;
use Test::More 0.98;
use WebService::MusicBrainz::WS2;


my $musicbrainz = new WebService::MusicBrainz::WS2;
isa_ok $musicbrainz, 'WebService::MusicBrainz::WS2';

done_testing;

