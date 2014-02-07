=head1 NAME

OneTool::LogManagement::Server - OneTool LogManagement Server module

=cut

package OneTool::LogManagement::Server;

use strict;
use warnings;

use FindBin;
use Log::Log4perl;
use Moose;

use lib "$FindBin::Bin/../lib/";

use OneTool;
use OneTool::Configuration;
use OneTool::LogManagement::Server::API qw( %server_api );

my $FILE_LOG = "$FindBin::Bin/../conf/itt_logmanagement_server.log.conf";

=head1 MOOSE OBJECT

=cut

extends 'OneTool::Daemon';

around BUILDARGS => sub 
{
    my $orig  = shift;
    my $class = shift;

    Log::Log4perl::init_and_watch($FILE_LOG, 10);
    printf "filelog: $FILE_LOG\n";
    my $logger = Log::Log4perl->get_logger('OneTool_logmanagement_server');
    
    if (@_ == 0)
    {
        # called as OneTool::Monitoring::Server->new();
        my $conf = OneTool::Configuration::Get({ module => 'itt_logmanagement_server' });

        $conf->{api} = \%server_api;
        $conf->{logger} = $logger;

        return $class->$orig($conf);
    }
    elsif ( @_ == 1 && defined $_[0]->{file} )
    {
        # called as OneTool::Monitoring::Server->new($fileconf);
        my $conf = OneTool::Configuration::Get({ file => $_[0]->{file} });

        return $class->$orig($conf);
    }
    else 
    {
        return $class->$orig(@_);
    }
};

=head1 SUBROUTINES/METHODS

=head2 Version()

Returns Server version

=cut

sub Version
{
    return ({ status => 'ok', data => { Version => $OneTool::VERSION } });
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

=head1 AUTHOR

Sebastien Thebert <contact@onetool.pm>

=cut