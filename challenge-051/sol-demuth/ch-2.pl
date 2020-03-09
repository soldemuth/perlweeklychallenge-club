#!/usr/bin/perl

use strict;
use warnings;

# solution is scaled for differing number of places!
my ($places) = @ARGV;
# avoid empty string math, below
my $n    = 1 . ( '0' x ($places - 1));
my @sets = ();
my $bfmt = '%0' . $places . 'b';

# create consecutive product sets, in order of elements included
# this is scalable for number of places
foreach my $np (1 .. $places) {
    my $i = 1;

    while (1) {
        my $b = sprintf $bfmt, $i;
        last if length($b) > $places;

        # just single or groups
        if ($b =~ /^(?:0*)1{$np}(?:0*)$/) {
            push @sets, [(split'', reverse $b)];
        }

        $i++;
    }
}

while (length($n) == $places) {
    my @a    = split'', $n;
    my $strN = $n;

    my $isProductsUniq = 1;
    my %found          = ();
    my @prods          = ();
    # For example, 263 is a Colorful Number
    # since 2, 6, 3, 2x6, 6x3, 2x6x3 are unique.
    foreach my $s (@sets) {
        my $p      = 1; #running product
        my $tmpset = [];

        foreach my $j (0 .. $#$s) {
            if ($s->[$j]) {
                my $d = $a[ $s->[$j] ];
                $p *= $d;

                push @$tmpset, $d;
            }
        }

        # only unique products allowed per set
        if (exists $found{$p}) {
            $isProductsUniq = 0;
            @prods          = ();

            last;
        } else {
            $found{$p} = undef; # minimizes memory usage

            push @prods, $tmpset;
        }
    }

    if ($isProductsUniq) { # found one!
        print join(', ',  map {join('x', @$_)} @prods);
        print "\n";
    }

    $n++;
}
