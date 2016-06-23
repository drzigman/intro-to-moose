package HasAccount;

use strict;
use warnings;

use Moose::Role;
use namespace::autoclean;

use Carp;

has 'balance' => (
    is => 'rw',
);

sub deposit {
    my $self   = shift;
    my $amount = shift;

    $self->balance( $self->balance + $amount );

    return $self;
}

sub withdraw {
    my $self   = shift;
    my $amount = shift;

    my $new_balance = $self->balance - $amount;

    if( $new_balance < 0 ) {
        croak 'Balance cannot be negative';
    }

    $self->balance( $new_balance );

    return $self;
}

1;
