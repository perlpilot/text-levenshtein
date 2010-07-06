use v6;
use Text::Levenshtein;
use Test;
plan 7;

is( distance("foo","foo") , 0, 'words are no distrance from themselves' );
is( distance("foo","bar") , 3, 'completely different word - same length' );

is( distance("foo","blat") , 4, 'completely different word - different length' );

is( distance("foo","fox") , 1, 'single letter change' );
is( distance("fox","foo") , 1, 'single letter change' );

is( distance("foo","moo") , 1, 'single letter change' );
is( distance("foo","oof") , 2, 'double letter change' );
