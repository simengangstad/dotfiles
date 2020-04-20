#!/usr/bin/perl

use strict;
use warnings;
use utf8;

my $acpi;
my $status;
my $percent;
my $full_text;
my $bat_number = $ENV{BLOCK_INSTANCE} || 0;

# read the first line of the "acpi" command output
open (ACPI, "acpi -b | grep 'Battery $bat_number' |") or die;
$acpi = <ACPI>;
close(ACPI);

# fail on unexpected output
if ($acpi !~ /: (\w+), (\d+)%/) {
	die "$acpi\n";
}

$status = $1;
$percent = $2;
$full_text = "$percent%";

if ($acpi =~ /(\d\d:\d\d):/) {
	$full_text .= " ($1)";
}


if ($status eq 'Charging') {
	print " ";
}

# consider color and urgent flag only on discharge
if ($status eq 'Discharging') {

 	if ($percent < 10) {
		print " ";
	} elsif ($percent < 35) {
		print " ";
	} elsif ($percent < 60) {
		print " ";
	} elsif ($percent < 85) {
		print " ";
	} elsif ($percent <= 100) {
		print " ";
	}

	if ($percent < 5) {
		exit(33);
	}
}

print "$full_text";

exit(0);
