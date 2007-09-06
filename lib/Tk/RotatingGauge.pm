#
# This file is part of Tk::RotatingGauge
# Copyright (c) 2007 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Tk::RotatingGauge;

use warnings;
use strict;

use POSIX qw[ floor ];
use Tk;
use Tk::Canvas;

use base qw[ Tk::Derived Tk::Canvas ];
Construct Tk::Widget 'RotatingGauge';


our $VERSION   = '0.01';

sub Populate {
    my( $self, $args ) = @_;


    $self->SUPER::Populate( $args );
    $self->ConfigSpecs(
        -from    => [ 'PASSIVE', undef, undef, 0   ],
        -visible => [ 'PASSIVE', undef, undef, 20  ],
        -to      => [ 'PASSIVE', undef, undef, 100 ],
        -value   => [ 'METHOD',  undef, undef, undef ],
    );
    my $val = exists $args->{-value} ? delete $args->{-value} : 50 ;
    $self->afterIdle( sub{ $self->configure(-value => $val) } );

    my $w = $self->cget('-width');
    my $h = $self->cget('-height');
    $self->createLine( 0, 1,  $w, 1  );
    $self->createLine( 0, $h, $w, $h );
    $self->afterIdle( sub {
        my $w = $self->cget('-width');
        $self->createLine( $w/2, 0, $w/2, $h, -fill=>'red', -width=>2)
    } );
}


sub value {
    my ($self, $value) = @_;

    my $from    = $self->cget('-from');
    my $to      = $self->cget('-to');

    #$value = $from if $value < $from;
    #$value = $to   if $value > $to;

    $self->delete( 'tick' );

    my $w = $self->{Configure}{-width};
    my $h = $self->{Configure}{-height};
    my $visible = $self->{Configure}{-visible};

    my $step = $w / $visible;
    my $frac = $value - int($value);
    my $num  = ( floor( $value - ($visible/2) ) + 1 ) % $to;

    foreach my $i ( 0 .. $visible ) {
        my $x   = ( 1 - $frac + $i) * $step;
        $self->createLine( $x, 0, $x, $h, -tags=>'tick' );
        $self->createText( $x+$step/2, $h/2, -text=>$num, -tags=>'tick' );
        $num = ($num+1) % $to;
    }
}



1;
__END__

=head1 NAME

Tk::RotatingGauge - a rotating gauge for Tk



=head1 SYNOPSIS

    use Tk::RotatingGauge;

    my $g = $mw->RotatingGauge(
    );



=head1 DESCRIPTION

This perl module provides a new Tk widget representing a gauge where the
current value always stays at the same place. Think about your old
mileage counters...




=head1 STANDARD OPTIONS

=head1 WIDGET-SPECIFIC OPTIONS

=head1 METHODS


=head2 value($val)


=begin pod-coverage

This pod section is meant to fool the pod coverage test.

=head2 Populate

=end pod-coverage


=head1 BUGS

Please report any bugs or feature requests to C<< < bug-tk-rotatinggauge at
rt.cpan.org> >>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tk-RotatingGauge>.  I will be
notified, and then you'll automatically be notified of progress on your
bug as I make changes.



=head1 SEE ALSO

C<Tk::RotatingGauge> development takes place on
L<http://tk-rotatinggauge.googlecode.com> - feel free to join us.


You can also look for information on this module at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tk-RotatingGauge>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tk-RotatingGauge>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tk-RotatingGauge>

=back



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2007 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut
