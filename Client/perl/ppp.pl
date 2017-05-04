#!/usr/bin/perl
%defs=();

$infile="";
$outfile="";
$emptylines=0;

for (@ARGV) {
	if (m/^-D(\w+?)(=(.+))?$/i) {$defs{$1}=$3?$3:1;}
	elsif (m/^-\?/) {
		print "usage: ppp [-e] [-D<name>=<val> ...] [-o outfile] [infile]\n";}
	elsif (m/^-o/i) {$of=1;}
	elsif (m/^-e/i) {$emptylines=1;}
	elsif ($of) {$outfile=$_;$of=0;}
	else {$infile=$_;}
}

if (!$infile) {open (IN,"-");} else {open (IN,"<",$infile) or die "$infile: ".$!;}
if (!$outfile) {open (OUT,">-");} else {open (OUT,">",$outfile) or die "$outfile: ".$!;}
 
# setup local variable space
$skip = 0;

# main loop
while (<IN>) {

	if (m/^#~~endif~~/) {
		$skip and $skip--;
		$emptylines and print OUT "\n";
		next;
	}

	if (m/^#~~ifdef~~\s+(\w+)/) {
		if ($skip || !defined($defs{$1})) {$skip++;}
		$emptylines and print OUT "\n";
		next;
	}
	 
	if (m/^#~~ifndef~~\s+(\w+)/) {
		if ($skip || defined($defs{$1})) {$skip++;}
		$emptylines and print OUT "\n";
		next;
	}

	if ($skip) {
		$emptylines and print OUT "\n";
		next;
	}

	for $i (keys(%defs)) {s/~~$i~~/$defs{$i}/g;}
	print OUT;
}
