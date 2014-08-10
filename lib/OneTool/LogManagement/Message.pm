package OneTool::LogManagement::Message;

=head1 NAME

OneTool::LogManagement::Message - OneTool LogManagement Message module

=cut

use strict;
use warnings;

use Moose;

use overload '""' => sub { 
    my $self = shift; 
    return ($self->id);
};

has 'id' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
    );

has loglevel => (
    is => 'rw',
    isa => 'Str',
    required => 1,
    );

has taxonomy => (
    is => 'rw',
    isa => 'Str',
    required => 1,
    );
1;

=head1 AUTHOR

Sebastien Thebert <contact@onetool.pm>

=cut