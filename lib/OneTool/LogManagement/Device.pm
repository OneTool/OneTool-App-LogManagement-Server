=head1 NAME

OneTool::LogManagement::Device - OneTool LogManagement Device module

=cut

package OneTool::LogManagement::Device;

use strict;
use warnings;

use AAT::XML;
use Octopussy::FS;

my $DIR_DEVICE = 'devices';

my ($dir_devices, $dir_pid) = (undef, undef);
my %filename;

=head2 List()

Gets List of Devices

=cut

sub List
{
    $dir_devices ||= Octopussy::FS::Directory($DIR_DEVICE);

    return (AAT::XML::Name_List($dir_devices));
}

=head2 Filename($device_name)

Gets the XML filename for the device '$device_name'

=cut

sub Filename
{
    my $device_name = shift;

    return (undef) if (!defined $device_name);

    return ($filename{"$device_name"}) if (defined $filename{"$device_name"});
    $dir_devices ||= Octopussy::FS::Directory($DIR_DEVICE);
    $filename{"$device_name"} = "$dir_devices/$device_name.xml";

    return ($filename{"$device_name"});
}

=head2 Configuration($device_name)

Gets the configuration for the device '$device_name'

=cut

sub Configuration
{
    my $device_name = shift;

    my $conf = AAT::XML::Read(Filename($device_name));
    if ((defined $conf) && (!defined $conf->{type}))
    {
        $conf->{type} = Octopussy::Parameter('devicetype');
    }

    return ($conf);
}

=head2 Configurations($sort)

Gets the configuration for all devices 

=cut

sub Configurations
{
    my $sort = shift || 'name';
    my (@configurations, @sorted_configurations) = ((), ());
    my @devices = List();

    foreach my $d (@devices)
    {
        my $conf = Configuration($d);
        next if ((!defined $conf) || (!defined $conf->{name}));
        my $status = 'Started'; #Octopussy::Device::Parse_Status($conf->{name});
        next if (!defined $status);
        #$conf->{status} = (
        #    $status == $STARTED
        #    ? 'Started'
        #    : ($status == $PAUSED ? 'Paused' : 'Stopped')
        #);
        #$conf->{action1} =
        #    ($conf->{status} eq 'Stopped' ? 'parse_pause' : 'parse_stop');
        #$conf->{action2} =
        #    ($conf->{status} eq 'Started' ? 'parse_pause' : 'parse_start');
        #$conf->{logtype} ||= 'syslog';
        push @configurations, $conf;
    }
    foreach my $c (sort { $a->{$sort} cmp $b->{$sort} } @configurations)
    {
        push @sorted_configurations, $c;
    }

    return (@sorted_configurations);
}

1;

=head1 AUTHOR

Sebastien Thebert <contact@onetool.pm>

=cut