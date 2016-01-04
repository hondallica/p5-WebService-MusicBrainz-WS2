use strict;
use Test::More 0.98;
use WebService::MusicBrainz::WS2;


my $musicbrainz = new WebService::MusicBrainz::WS2;
my $mbid = '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab';

my $res = $musicbrainz->artist($mbid);
is $res->{status_code}, 200;
is $res->{content}{name}, 'Metallica';

for my $subquery (qw/recordings releases release-groups works/) {
    my $res = $musicbrainz->artist($mbid, { inc => $subquery });
    is $res->{status_code}, 200;
    is ref $res->{content}{$subquery}, 'ARRAY';
}


done_testing;

