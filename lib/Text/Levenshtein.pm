module Text::Levenshtein;

multi sub distance ($s, @t) is export {
    gather for @t -> $t { take distance($s,$t) }
}

multi sub distance ($s, $t) is export {
    return 0 if $s eq $t;

    my @result;

    my $n = $s.chars;
    my $m = $t.chars;
    my @d;    

    @d[0][0] = 0;
    for 1..$n -> $i {
        @d[$i][0] = $i;
        return $i if $i != $n && ($s.substr($i) // '') eq ($t.substr($i) // '');
    }

    for 1..$m -> $j {
        @d[0][$j] = $j;
        return $j if $j != $m && ($s.substr($j) // '') eq ($t.substr($j) // '');
    }

    for 1..$n -> $i {
        my $s-i = $s.substr($i-1,1);
        for 1..$m -> $j {
            my $k = $s-i eq $t.substr($j-1,1) ?? 0 !! 1;
            @d[$i][$j] = (@d[$i-1][$j]+1, @d[$i][$j-1]+1, @d[$i-1][$j-1] + $k).min;
        }
    }
    @result.push: @d[$n][$m];

    return @result[0];
}


# vim: ft=perl6
