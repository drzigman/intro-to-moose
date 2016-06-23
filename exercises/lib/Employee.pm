package Employee;

use strict;
use warnings;

use Moose;
use namespace::autoclean;

extends 'Person';

has 'title' => (
    is => 'rw',
);

has 'salary' => (
    is => 'rw',
);

has 'ssn' => (
    is => 'ro',
);

override full_name => sub {
    my $self = shift;

    return sprintf("%s (%s)", super(), $self->title );
};

__PACKAGE__->meta->make_immutable;

1;
