module Text::Levenshtein;

sub distance is export ($s, *@targets) {
    my $n = $s.chars;
    my @result;

    for @targets -> $t {
        if ($s eq $t) { @result.push: 0; next }
        my @d;
        my $cost = 0;

        my $m = $t.chars;
        unless $n { @result.push: $m; next }
        unless $m { @result.push: $n; next }


        @d[0] = [];         # XXX Work around rakudo bug
        @d[0][0] = 0;
        for 1..$n -> $i {
            @d[$i] = [];    # XXX Work around rakudo bug 
            if ($i != $n && $s.substr($i) eq $t.substr($i)) { @result.push: $i; next; }
            @d[$i][0] = $i;
        }

        for 1..$m -> $j {
            if ($j != $m && $s.substr($j) eq $t.substr($j)) { @result.push: $j; next; }
            @d[0][$j] = $j;
        }

        for 1..$n -> $i {
            my $s-i = $s.substr($i-1,1);
            for 1..$m -> $j {
                my $k = $s-i eq $t.substr($j-1,1) ?? 0 !! 1;
                @d[$i][$j] = (@d[$i-1][$j]+1, @d[$i][$j-1]+1, @d[$i-1][$j-1] + $k).min;
            }
        }

        @result.push: @d[$n][$m];
    }
    return @result;
}


# vim: ft=perl6
