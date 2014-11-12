package Getopt::Long::Patch::DumpSpec;

our $DATE = '2014-11-12'; # DATE
our $VERSION = '0.01'; # VERSION

use 5.010001;
use strict;
no warnings;

use Data::Dump;
use Module::Patch 0.19 qw();
use base qw(Module::Patch);

our %config;

sub _dump {
    print "# BEGIN DUMPSPEC $config{-tag}\n";
    dd @_;
    print "# END DUMPSPEC $config{-tag}\n";
}

sub _GetOptions(@) {
    # discard optional first hash argument
    if (ref($_[0]) eq 'HASH') {
        shift;
    }
    my %spec = @_;
    _dump(\%spec);
    exit 0;
}

sub _GetOptionsFromArray(@) {
    # discard array
    shift;
    # discard optional first hash argument
    if (ref($_[0]) eq 'HASH') {
        shift;
    }
    my %spec = @_;
    _dump(\%spec);
    exit 0;
}

sub _GetOptionsFromString(@) {
    # discard string
    shift;
    # discard optional first hash argument
    if (ref($_[0]) eq 'HASH') {
        shift;
    }
    my %spec = @_;
    _dump(\%spec);
    exit 0;
}

sub patch_data {
    return {
        v => 3,
        patches => [
            {
                action      => 'replace',
                sub_name    => 'GetOptions',
                code        => \&_GetOptions,
            },
            {
                action      => 'replace',
                sub_name    => 'GetOptionsFromArray',
                code        => \&_GetOptionsFromArray,
            },
            {
                action      => 'replace',
                sub_name    => 'GetOptionsFromString',
                code        => \&_GetOptionsFromString,
            },
        ],
        config => {
            -tag => {
                schema  => 'str*',
                default => 'TAG',
            },
        },
   };
}

1;
# ABSTRACT: Patch Getopt::Long to dump option spec

__END__

=pod

=encoding UTF-8

=head1 NAME

Getopt::Long::Patch::DumpSpec - Patch Getopt::Long to dump option spec

=head1 VERSION

This document describes version 0.01 of Getopt::Long::Patch::DumpSpec (from Perl distribution App-GenBashCompleter), released on 2014-11-12.

=for Pod::Coverage ^(patch_data)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-GenBashCompleter>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-GenBashCompleter>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-GenBashCompleter>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
