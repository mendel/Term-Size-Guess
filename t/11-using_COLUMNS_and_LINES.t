#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Without::Module qw/ Term::Size::Any /;

$ENV{COLUMNS} = 1234;
$ENV{LINES}   = 5678;

use Term::Size::Guess;

is( scalar Term::Size::Guess::chars, 1234,
    "chars() works in scalar context");

is_deeply( [ Term::Size::Guess::chars ], [ 1234, 5678 ],
    "chars() works in list context");

done_testing;
