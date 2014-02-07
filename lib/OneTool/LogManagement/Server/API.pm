=head1 NAME

OneTool::LogManagement::Server::API - OneTool LogManagement Server API module

=cut

package OneTool::LogManagement::Server::API;

use strict;
use warnings;

use Exporter 'import';
use FindBin;
use JSON;

use lib "$FindBin::Bin/../lib/";
use OneTool::LogManagement::Device;
use OneTool::LogManagement::Server;

our @EXPORT_OK = qw(%server_api);

my $API_ROOT = '/api/logmanagement_server';

our %server_api = (
    "$API_ROOT/version" => {
        method => 'GET',
        action => sub {
            my ($self) = @_;
            return (to_json($self->Version())); 
            } 
        },
    "$API_ROOT/device/configuration" => {
        method => 'GET',
        action => sub {
            my ($self, $params) = @_;
            my @configurations = ();
            foreach my $k (keys %{$params})
            {
                printf "$k: $params->{$k}\n";
            }
            if (ref $params->{device} eq 'ARRAY')
            {
                foreach my $d (@{$params->{device}})
                {
                    push @configurations, OneTool::LogManagement::Device::Configuration($d);
                }
            }
            else
            {
                push @configurations, OneTool::LogManagement::Device::Configuration($params->{device});
            }
            return (to_json(\@configurations)); 
            } 
        },
    "$API_ROOT/device/configurations" => {
        method => 'GET',
        action => sub {
            my ($self) = @_;
            my @configurations = OneTool::LogManagement::Device::Configurations();
            return (to_json(\@configurations)); 
            } 
        },
    );


1;

=head1 AUTHOR

Sebastien Thebert <contact@onetool.pm>

=cut