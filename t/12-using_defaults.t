#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Without::Module qw/ Term::Size::Any /;

delete $ENV{COLUMNS};
delete $ENV{LINES};

use Term::Size::Guess;

is( scalar Term::Size::Guess::chars, 80,
    "chars() works in scalar context");

is_deeply( [ Term::Size::Guess::chars ], [ 80, 24 ],
    "chars() works in list context");

done_testing;
