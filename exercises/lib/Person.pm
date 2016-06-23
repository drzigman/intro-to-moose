package Person;

use strict;
use warnings;

use Moose;
use namespace::autoclean;

use Data::Util qw( is_hash_ref is_array_ref );

with 'Printable', 'HasAccount';

has 'first_name' => (
    is       => 'rw',
    required => 1,
);

has 'last_name' => (
    is       => 'rw',
    required => 1,
);

has 'title' => (
    is        => 'rw',
    predicate => 'has_title',
    clearer   => 'clear_title',
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

	my $full_name = $self->first_name . ' ' . $self->last_name;

    if( $self->has_title ) {
		return sprintf("%s (%s)", $full_name, $self->title );
    }
    else {
        return $full_name;
    }
}

before full_name => sub {
    push @Person::CALL, 'calling full_name';
};

around full_name => sub {
    my $orig = shift;
    my $self = shift;

    my $full_name = $self->$orig( @_ );

    if( $self->last_name eq 'Wall' ) {
        return sprintf('*%s*', $full_name);
    }

    return $full_name;
};

after full_name => sub {
    push @Person::CALL, 'called full_name';
};

sub as_string {
    my $self = shift;

    return $self->full_name;
}

__PACKAGE__->meta->make_immutable;

1;
