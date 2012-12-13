package Term::Size::Guess;

use strict;

=head1 NAME

Term::Size::Guess - Guess terminal size

=head1 SYNOPSIS

    use Term::Size::Guess;

    # on *STDIN{IO}
    my ($columns, $rows) = Term::Size::Guess::chars;

    # on $fh
    my ($columns, $rows) = Term::Size::Guess::chars($fh);

=head1 DESCRIPTION

Tries to guess terminal width.

All you need to get this work, is:

1) Install Term::Size::Any, or

2) Export C<$COLUMNS> and C<$LINES> from your shell.

(Warning to bash users: C<< echo $COLUMNS >> / C<<echo $LINES >> may be showing
you the bash variable, not C<< $ENV{COLUMNS} >> / C<< $ENV{LINES} >>. C<<
export COLUMNS=$COLUMNS LINES=$LINES >> and you should see that C<< env >> now
lists COLUMNS/LINES.)

As last resort, a default value of 80 * 24 chars will be used.

=cut

our $VERSION = '1.00000';

=head1 METHODS

=head2 chars

  ($columns, $rows) = chars($fh);
  $columns = chars($fh);
  ($columns, $rows) = chars();
  $columns = chars();

Returns the terminal size in units of characters corresponding to the given
filehandle $fh. If the argument is omitted, C<< *STDIN{IO} >> is used. In
scalar context, it returns the terminal width.

It tries the following methods to get the terminal size until one of them
succeeds:

=over

=item *

Tries to load L<Term::Size::Any> and uses L<Term::Size::Any/chars>.

=item *

Uses the C<COLUMNS> and C<LINES> environment variables if they're set.

=item *

Uses the defaults of 80 and 24 for the width and height, respectively.

=back

=cut

sub chars {
    my ($width, $height) = eval q{
        use Term::Size::Any;

        Term::Size::Any::chars(@_);
    };

    if ($@) {
        $width = $ENV{COLUMNS}
            if exists $ENV{COLUMNS} && $ENV{COLUMNS} =~ m/^\d+$/;

        $height = $ENV{LINES}
            if wantarray && exists $ENV{LINES} && $ENV{LINES} =~ m/^\d+$/;
    }

    $width  = 80 if !$width;
    $height = 24 if wantarray && !$height;

    return wantarray ? ($width, $height) : $width;
}


=head1 AUTHORS

Catalyst Contributors, see Catalyst.pm

=head1 COPYRIGHT

This library is free software. You can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
