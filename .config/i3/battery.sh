#!/usr/bin/perl

use strict;
use warnings;
use utf8;

my $acpi;
my $status;
my $percent;
my $full_text;
my $icon;
my $bat_number = $ENV{BLOCK_INSTANCE} || 0;

# read the first line of the "acpi" command output
open (ACPI, "acpi -b | grep 'Battery $bat_number' |") or die;
$acpi = <ACPI>;
close(ACPI);

# fail on unexpected icon
if ($acpi !~ /: (\w+), (\d+)%/) {
	die "$acpi\n";
}

$status = $1;
$percent = $2;
$full_text = "$percent%";

# if ($acpi =~ /(\d\d:\d\d):/) {
#	$full_text .= " ($1)";
#}

# consider color and urgent flag only on discharge
if ($status eq 'Discharging') {

 	if ($percent < 10) {
		$icon=" ";
	} elsif ($percent < 35) {
		$icon=" ";
	} elsif ($percent < 60) {
		$icon=" ";
	} elsif ($percent < 85) {
		$icon=" ";
	} elsif ($percent <= 100) {
		$icon=" ";
	}
}
else {
	$icon="  ";
}


print "$icon $full_text";

exit(0);
