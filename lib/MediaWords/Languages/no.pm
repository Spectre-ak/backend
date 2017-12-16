package MediaWords::Languages::no;
use Moose;
with 'MediaWords::Languages::Language';

#
# Norwegian (Bokmål)
#

use strict;
use warnings;
use utf8;

use Modern::Perl "2015";
use MediaWords::CommonLibs;

sub language_code
{
    return 'no';
}

sub fetch_and_return_stop_words
{
    my $self = shift;
    return $self->_get_stop_words_from_file( 'lib/MediaWords/Languages/resources/no_stopwords.txt' );
}

sub stem
{
    my ( $self, $words ) = @_;
    return $self->_stem_with_lingua_stem_snowball( 'no', 'UTF-8', $words );
}

sub split_text_to_sentences
{
    my ( $self, $story_text ) = @_;
    return $self->_tokenize_text_with_lingua_sentence( 'no',
        'lib/MediaWords/Languages/resources/no_nonbreaking_prefixes.txt', $story_text );
}

sub split_sentence_to_words
{
    my ( $self, $sentence ) = @_;
    return $self->_tokenize_with_spaces( $sentence );
}

1;
