#!/usr/bin/perl

=head1 NAME

onetool_logmanagement_server.pl - LogManagement Server Program from the OneTool Suite

=cut

use strict;
use warnings;

use FindBin;

use lib "$FindBin::Bin/../lib/";

use OneTool::LogManagement::Server::Command;

OneTool::LogManagement::Server::Command->run();

=head1 AUTHOR

Sebastien Thebert <contact@onetool.pm>

=cut