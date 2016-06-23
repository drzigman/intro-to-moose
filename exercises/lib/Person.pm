package Person;

use strict;
use warnings;

use Moose;
use namespace::autoclean;

use Data::Util qw( is_hash_ref is_array_ref );

has 'first_name' => (
    is => 'rw',
);

has 'last_name' => (
    is => 'rw',
);

sub BUILDARGS {
    my $class = shift;

    # Allow calling with ->new( [ 'Lisa', 'Smith' ] );
	if ( @_ == 1 && is_array_ref( $_[0] ) ) {
        my $args = $_[0];

	    return {
            first_name => $args->[0],
            last_name  => $args->[1],
        };
	}

	return $class->SUPER::BUILDARGS( @_ );
}

sub full_name {
    my $self = shift;

    return $self->first_name . ' ' . $self->last_name;
}

__PACKAGE__->meta->make_immutable;

1;
