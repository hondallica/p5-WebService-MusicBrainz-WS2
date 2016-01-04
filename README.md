# NAME

WebService::MusicBrainz::WS2 - MusicBrainz Web Service version2 client library

# SYNOPSIS

    use WebService::MusicBrainz::WS2;

    my $musicbrainz = new WebService::MusicBrainz::WS2;

# DESCRIPTION

The module provides a simple interface to the MusicBrainz API.

# METHODS

## request

    my $mbid = '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab'; # Metallica
    my $res = $musicbrainz->request($musicbrainz->url . 'artist/' . $mbid);

## artist

    my $mbid = '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab';
    my $res = $musicbrainz->artist($mbid);

    # Subqueries
    $res = $musicbrainz->artist($mbid, { inc => 'recordings' });
    $res = $musicbrainz->artist($mbid, { inc => 'releases' });
    $res = $musicbrainz->artist($mbid, { inc => 'release-groups' });
    $res = $musicbrainz->artist($mbid, { inc => 'works' });
    $res = $musicbrainz->artist($mbid, { inc => 'recordings+releases' });

# SEE ALSO

[https://musicbrainz.org/doc/Development/XML\_Web\_Service/Version\_2](https://musicbrainz.org/doc/Development/XML_Web_Service/Version_2)
[https://musicbrainz.org/doc/Development/JSON\_Web\_Service](https://musicbrainz.org/doc/Development/JSON_Web_Service)

# LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Hondallica &lt;hondallica@gmail.com>
