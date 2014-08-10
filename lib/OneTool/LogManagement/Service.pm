package OneTool::LogManagement::Service;
=head1 NAME

OneTool::LogManagement::Service - OneTool LogManagement Service module

=head1 DESCRIPTION

=head1 SYNOPSIS

    use OneTool::LogManagement::Service;
    
    my $service = OneTool::LogManagement::Service->new(
        name => 'servicename',
        description => 'description of this service',
        messages => []
        );

    printf "$service->name";

=cut

use strict;
use warnings;

use Moose;

use OneTool::LogManagement::Message;

has 'name' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
    );

has 'version' => (
    is => 'rw',
    isa => 'Str',
    #required => 1,
    );

has 'description' => (
    is => 'rw', 
    isa => 'Str',
    );

has 'messages' => (
    is => 'rw',
    isa => 'ArrayRef[OneTool::LogManagement::Message]',
    );

=head1 METHODS

=head2 add_message($msg)

=cut

sub add_message
{
    my ($self, $msg) = @_;

    push @{$self->messages}, $msg;
}

=head2 count_messages()

=cut

sub count_messages
{
    my $self = shift;

    return (scalar @{$self->messages});
}

1;

=head1 AUTHOR

Sebastien Thebert <contact@onetool.pm>

=cut