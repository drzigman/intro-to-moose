package Employee;

use strict;
use warnings;

use Moose;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

extends 'Person';

subtype 'PositiveInt',
    as 'Int',
    where { $_ > 0 },
    message { "$_ is not a positive integer" };

subtype 'SalaryLevel',
    as 'Int',
    where { $_ > 0 && $_ <= 10 },
    message { "$_ is not a valid salary level" };

subtype 'SSN',
    as 'Str',
    where { $_ =~ m/^\d\d\d-\d\d-\d\d\d\d$/ },
    message { "$_ is not a valid SSN" };

has '+title' => (
    default => 'Worker',
);

has 'salary' => (
    is       => 'ro',
    isa      => 'PositiveInt',
    lazy     => 1,
    builder  => '_build_salary',
    init_arg => undef,
);

has 'ssn' => (
    is  => 'ro',
    isa => 'SSN',
);

has 'salary_level' => (
    is      => 'rw',
    isa     => 'SalaryLevel',
    default => 1,
);

sub _build_salary {
    my $self = shift;

    return $self->salary_level * 10000;
}

__PACKAGE__->meta->make_immutable;

1;
