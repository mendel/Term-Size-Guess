#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

# mock Term::Size::Any
{
    package Term::Size::Any;

    use strict;
    use warnings;

    sub chars {
        return wantarray ? (1234, 5678) : 1234;
    }

    $INC{'Term/Size/Any.pm'} = 1;
}

$ENV{COLUMNS} = 180;
$ENV{LINES}   = 124;

use Term::Size::Guess;

is( scalar Term::Size::Guess::chars, 1234,
    "chars() works in scalar context");

is_deeply( [ Term::Size::Guess::chars ], [ 1234, 5678 ],
    "chars() works in list context");

done_testing;
