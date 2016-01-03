use strict;
use Test::More 0.98;
use WebService::MusicBrainz::WS2;


my $musicbrainz = new WebService::MusicBrainz::WS2;

is $musicbrainz->retry, 3;
is $musicbrainz->auto_decode_json, 1;

my $mbid = '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab';
my $res = $musicbrainz->request($musicbrainz->url . 'artist/' . $mbid);

ok exists $res->{minor_version};
ok exists $res->{status_code};
ok exists $res->{content};
ok exists $res->{headers};
ok exists $res->{message};

is ref $res->{headers}, 'ARRAY';
is ref $res->{content}, 'HASH';
is $res->{status_code}, 200;


$musicbrainz->auto_decode_json(0);
my $res = $musicbrainz->request($musicbrainz->url . 'artist/' . $mbid);
is ref \($res->{content}), 'SCALAR';


done_testing;

