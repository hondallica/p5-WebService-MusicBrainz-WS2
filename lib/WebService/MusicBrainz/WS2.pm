package WebService::MusicBrainz::WS2;
use JSON::XS;
use Cache::LRU;
use Net::DNS::Lite;
use Furl;
use URI;
use URI::QueryParam;
use Carp;
use Moo;
use namespace::clean;
our $VERSION = "0.01";


$Net::DNS::Lite::CACHE = Cache::LRU->new( size => 512 );

has 'http' => (
    is => 'rw',
    required => 1,
    default  => sub {
        my $http = Furl::HTTP->new(
            inet_aton => \&Net::DNS::Lite::inet_aton,
            agent => 'WebService::MusicBrainz::WS2/' . $VERSION,
            headers => [ 'Accept-Encoding' => 'gzip',],
        );
        return $http;
    },
);

has url => (
    is => 'rw',
    required => 1,
    default => sub {
        my $uri = new URI;
        $uri->scheme('http');
        $uri->host('musicbrainz.org');
        $uri->path('ws/2/');
        return $uri;
    },
);

has format => (
    is => 'rw',
    required => 1,
    default => sub { return 'json' },
);

has retry => (
    is => 'rw',
    required => 1,
    default => sub { return 3 },
);

has auto_decode_json => (
    is => 'rw',
    required => 1,
    default => sub { return 1 },
);

sub artist {
    my ( $self, $mbid, $param ) = @_;
    my $url = $self->url . 'artist/' . $mbid;
    return $self->request($url, $param);
}

sub request {
    my ( $self, $url, $param ) = @_;
    my %response;
    my @keys = qw(minor_version status_code message headers content);

    $url = new URI($url) unless ref $url eq 'URI';
    $param->{fmt} = $self->format;
    $url->query_form($param);

    eval {
        for (my $i = 0; $i <= $self->retry; $i++) {
            @response{@keys} = $self->http->request(url => $url);
            $response{content} = decode_json $response{content} if $self->{auto_decode_json};
            last if $response{status_code} == 200;
        }
    };

    return \%response;
}


1;
__END__

=encoding utf-8

=head1 NAME

WebService::MusicBrainz::WS2 - MusicBrainz Web Service version2 client library

=head1 SYNOPSIS

    use WebService::MusicBrainz::WS2;

    my $musicbrainz = new WebService::MusicBrainz::WS2;

=head1 DESCRIPTION

The module provides a simple interface to the MusicBrainz API.

=head1 METHODS

=head2 request

    my $mbid = '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab'; # Metallica
    my $res = $musicbrainz->request($musicbrainz->url . 'artist/' . $mbid);

=head2 artist

    my $mbid = '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab';
    my $res = $musicbrainz->artist($mbid);

    # Subqueries
    $res = $musicbrainz->artist($mbid, { inc => 'recordings' });
    $res = $musicbrainz->artist($mbid, { inc => 'releases' });
    $res = $musicbrainz->artist($mbid, { inc => 'release-groups' });
    $res = $musicbrainz->artist($mbid, { inc => 'works' });
    $res = $musicbrainz->artist($mbid, { inc => 'recordings+releases' });

=head1 SEE ALSO

L<https://musicbrainz.org/doc/Development/XML_Web_Service/Version_2>
L<https://musicbrainz.org/doc/Development/JSON_Web_Service>

=head1 LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hondallica E<lt>hondallica@gmail.comE<gt>

=cut
