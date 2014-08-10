#!/usr/bin/perl

use FindBin;
use Test::More;

use lib "$FindBin::Bin/../../../../lib/";

use_ok('OneTool::LogManagement::Message');
use_ok('OneTool::LogManagement::Service');

my $test_message = OneTool::LogManagement::Message->new(
    id => 'id_of_the_first_message',
    loglevel => 'Information',
    taxonomy => 'Auth.Failure'
    );
my $test_message2 = OneTool::LogManagement::Message->new(
    id => 'id_of_the_second_message',
    loglevel => 'Critical',
    taxonomy => 'Network.Error'
    );
    
my %test = (
    servicename => 'Name of this service',
    description => 'Description of this service',
    messages => [$test_message],
    );


my $service = OneTool::LogManagement::Service->new(
        name => $test{servicename},
        description => $test{description},
        messages => [$test_message]
        );

printf "%s\n", $service->name;
printf "%s\n", join(', ', @{$service->messages});

$service->add_message($test_message2);

printf "%s\n", join(', ', @{$service->messages});

printf "Total: %d\n", $service->count_messages;

foreach my $msg (@{$service->messages})
{
    printf "ID: %s\n\tTaxonomy: %s\n\tLoglevel: %s\n\n", 
        $msg->id, 
        $msg->taxonomy, 
        $msg->loglevel;
}

done_testing(2);

=head1 AUTHOR

Sebastien Thebert <contact@onetool.pm>

=cut