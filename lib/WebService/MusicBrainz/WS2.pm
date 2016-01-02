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
