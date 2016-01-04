use strict;
use Test::More 0.98;
use WebService::MusicBrainz::WS2;


my $musicbrainz = new WebService::MusicBrainz::WS2;
my $mbid = '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab';

my @subqueries = qw/recordings releases release-groups works/;

my $res = $musicbrainz->artist($mbid);
is $res->{status_code}, 200;
is $res->{content}{name}, 'Metallica';

for my $subquery (@subqueries) {
    my $res = $musicbrainz->artist($mbid, { inc => $subquery });
    is $res->{status_code}, 200;
    is ref $res->{content}{$subquery}, 'ARRAY';
}

my $res = $musicbrainz->artist($mbid, { inc => 'recordings+releases' });
is ref $res->{content}{'recordings'}, 'ARRAY';
is ref $res->{content}{'releases'}, 'ARRAY';

my $subquery = join '+', @subqueries;
my $res = $musicbrainz->artist($mbid, { inc => $subquery });
is ref $res->{content}{'recordings'}, 'ARRAY';
is ref $res->{content}{'releases'}, 'ARRAY';
is ref $res->{content}{'release-groups'}, 'ARRAY';
is ref $res->{content}{'works'}, 'ARRAY';


done_testing;

