=head1 NAME

OneTool::LogManagement::Server::Command - Module handling everything for onetool_logmanagement_server.pl

=head1 DESCRIPTION

Module handling everything for onetool_logmanagement_server.pl

=head1 SYNOPSIS

onetool_logmanagement_server.pl [options]

=head1 OPTIONS

=over 8

=item B<-D,--debug>

Sets Debug mode

=item B<-h,--help>

Prints this Help

=item B<-v,--version>

Prints version

=back

=cut

package OneTool::LogManagement::Server::Command;

use strict;
use warnings;

use FindBin;
use Getopt::Long qw(:config no_ignore_case);
use Pod::Find qw(pod_where);
use Pod::Usage;

use lib "$FindBin::Bin/../lib/";

use OneTool::App;
use OneTool::LogManagement::Server;

__PACKAGE__->run(@ARGV) unless caller;

my $PROGRAM = 'onetool_logmanagement_server.pl';

=head1 SUBROUTINES/METHODS

=head2 Daemon_Start()

Launch OneTool LogManagement Server as Daemon

=cut

sub Daemon_Start
{
    my $server = OneTool::LogManagement::Server->new();

    if (fork())
    {    #father -> API Listener
        $server->Listener();
    }

    return (undef);
}

=head2 run(@ARGV)

Runs Command Line

=cut

sub run
{
    my $self = shift;
    my %opt  = ();

    local @ARGV = @_;
    my @options = @OneTool::App::DEFAULT_OPTIONS;
    push @options, 'start', 'stop';
    my $status = GetOptions(\%opt, @options);

    pod2usage(
        -exitval => 'NOEXIT', 
        -input => pod_where({-inc => 1}, __PACKAGE__)) 
        if ((!$status) || ($opt{help}));
        
    if ($opt{version})
    {
        printf "%s v%s\n", $PROGRAM, $OneTool::LogManagement::Server::VERSION;
    }

    Daemon_Start() if ($opt{start});

    return ($status);
}

1;

=head1 AUTHOR

Sebastien Thebert <contact@onetool.pm>

=cut
