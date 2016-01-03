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

sub request {
    my ( $self, $url ) = @_;
    my %response;
    my @keys = qw(minor_version status_code message headers content);

    $url = new URI($url) unless ref $url eq 'URI';
    $url->query_form('fmt' => $self->format);

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

WebService::MusicBrainz::WS2 - It's new $module

=head1 SYNOPSIS

    use WebService::MusicBrainz::WS2;

=head1 DESCRIPTION

WebService::MusicBrainz::WS2 is ...

=head1 LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hondallica E<lt>hondallica@gmail.comE<gt>

=cut
