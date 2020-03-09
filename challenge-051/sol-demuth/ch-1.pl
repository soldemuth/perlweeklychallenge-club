#!/usr/bin/perl

use strict;
use warnings;

#$ perl ch-1.pl 0 '(-25, -10, -7, -3, 2, 4, 8, 10)'
my ($t, $nstr) = @ARGV;
my @L          = $nstr =~ /(\-?\d+)/g;
my %printed    = ();

print "Target = $t\n";
print '@L     = ('
    . join(', ', @L)
    . ")\n\n";

foreach my $i (@L) {
    foreach my $j (@L) {
        next if $i == $j;

        foreach my $k (@L) {
            if (
                   $i == $k
                || $j == $k
            ) {
                next;
            }

            if ($t == $i + $j + $k) {
                my $solution = join(' + ', sort {$a <=> $b} $i, $j, $k);

                unless (exists $printed{$solution}) {
                    print "$t = ($solution)\n";

                    $printed{$solution} = undef;
                }
            }
        }
    }
}
