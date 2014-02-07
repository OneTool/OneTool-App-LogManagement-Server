#!/usr/bin/perl

=head1 NAME

onetool_logmanagement_server - LogManagement Server Program from the OneTool Suite

=cut

use strict;
use warnings;

use FindBin;

use lib "$FindBin::Bin/../lib/";

use OneTool::LogManagement::Server::App;

OneTool::LogManagement::Server::App->run(@ARGV);

=head1 AUTHOR

Sebastien Thebert <contact@onetool.pm>

=cut