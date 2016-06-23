package BankAccount;

use strict;
use warnings;

use Moose;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

use Carp;

has 'balance' => (
    is      => 'rw',
    default => 100,
    trigger => sub {
        if( scalar @_ == 2 ) {
            # No old_value so there is nothing to record
            return;
        }

        my ( $self, $new_value, $old_value ) = @_;

        $self->record_history( $old_value );
    },
);

has 'owner' => (
    is       => 'rw',
    isa      => 'Person',
    weak_ref => 1,
);

has 'history' => (
    traits  => [ 'Array' ],
    is      => 'ro',
    isa     => 'ArrayRef[Int]',
    default => sub { [ ] },
    handles => {
        record_history => 'push',
    }
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

__PACKAGE__->meta->make_immutable;
1;
