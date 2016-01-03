use strict;
use Test::More 0.98;
use WebService::MusicBrainz::WS2;


my $musicbrainz = new WebService::MusicBrainz::WS2;

my $mbid = '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab';
my $res = $musicbrainz->request($musicbrainz->url . 'artist/' . $mbid);

ok exists $res->{minor_version};
ok exists $res->{status_code};
ok exists $res->{content};
ok exists $res->{headers};
ok exists $res->{message};

is $res->{status_code}, 200;
is ref $res->{headers}, 'ARRAY';


done_testing;

