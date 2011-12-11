package Data::Delete;

use strict;
use warnings;
use utf8;

sub delete_deeply {
    my $ref = shift;
    return 0 if @_;

    if ( is_hash_ref($ref) ) {
        return delete_deeply_hash_ref($ref);
    }
    elsif ( is_array_ref($ref) ) {
        return delete_deeply_array_ref($ref);
    }
    return 0;
}

sub delete_deeply_hash_ref {
    my $ref = shift;
    return 0 if @_;

    if ( is_hash_ref($ref) ) {
        for my $key ( keys %$ref ) {
            if ( is_literal( $ref->{$key} ) ) {
                delete $ref->{$key};
            }
            else {
                delete_deeply( $ref->{$key} );
                delete $ref->{$key};
            }
        }
        return 1;
    }
    return 0;
}

sub delete_deeply_array_ref {
    my $ref = shift;
    return 0 if @_;

    if ( is_array_ref($ref) ) {
        my $i = 0;
        for (@$ref) {
            if ( is_literal($_) ) {
                delete $ref->[$i];
            }
            else {
                delete_deeply( $ref->[$i] );
                delete $ref->[$i];
            }
            ++$i;
        }
        return 1;
    }
    return 0;
}

sub is_array_ref {
    my $reference = shift;
    return 0 if @_;

    if ( ref($reference) eq 'ARRAY' ) {
        return 1;
    }
    return 0;
}

sub is_hash_ref {
    my $reference = shift;
    return 0 if @_;

    if ( ref($reference) eq 'HASH' ) {
        return 1;
    }
    return 0;
}

sub is_literal {
    my $value = shift;
    return 0 if @_;

    if ( !is_hash_ref($value) && !is_array_ref($value) ) {
        return 1;
    }
    return 0;
}

1;
