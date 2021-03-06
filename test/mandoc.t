#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use Test::More tests => 3;

SKIP: {
	my $mandoc_present = 0;

	for my $path (split(qr{:}, $ENV{PATH})) {
		if (-x "${path}/mandoc") {
			$mandoc_present = 1;
			last;
		}
	}

	if ( not $mandoc_present ) {
		diag('mandoc not installed, test skipped. This is NOT fatal.');
		skip( 'mandoc not installed', 3 );
	}

	for my $file ( 'feh', 'feh-cam', 'gen-cam-menu' ) {
		qx{mandoc -Tlint -Werror man/${file}.1};
		is( $?, 0, "${file}.1: Valid mdoc syntax" );
	}
}
