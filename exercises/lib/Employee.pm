package Employee;

use strict;
use warnings;

use Moose;
use namespace::autoclean;

extends 'Person';

has '+title' => (
    default => 'Worker',
);

has 'salary' => (
    is       => 'ro',
    lazy     => 1,
    builder  => '_build_salary',
    init_arg => undef,
);

has 'ssn' => (
    is => 'ro',
);

has 'salary_level' => (
    is      => 'rw',
    default => 1,
);

sub _build_salary {
    my $self = shift;

    return $self->salary_level * 10000;
}

__PACKAGE__->meta->make_immutable;

1;
