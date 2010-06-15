package XML::FeedPP::MediaWords;

use strict;
use warnings;
use Perl6::Say;
use Data::Dumper;
use XML::FeedPP;

use Class::Std;
{

    my %feedPP : ATTR;

    sub BUILD
    {
        my ( $self, $ident, $arg_ref ) = @_;

        my $content = $arg_ref->{ content };
        my $type    = $arg_ref->{ type };

        my $fp;
        eval { $fp = XML::FeedPP->new( $content, -type => $type ); };

        $feedPP{ $ident } = $fp;
    }

    sub _wrapper_if_necessary
    {
        my ( $obj ) = @_;

        return $obj if ( !$obj->isa( 'XML::FeedPP::RSS::Item' ) );

        return XML::FeedPP::RSS::Item::MediaWords->create_wrapped_rss_item( $obj );
    }

    sub get_item
    {
        my $self = shift;

        my @args  = @_;
        my @items = $feedPP{ ident $self}->get_item( @args );

        my @ret = map { _wrapper_if_necessary( $_ ) } @items;

        if ( defined( $args[ 0 ] ) )
        {
            return $ret[ 0 ];
        }
        elsif ( wantarray )
        {
            return @ret;
        }
        else
        {
            return scalar @ret;
        }
    }

    sub AUTOMETHOD
    {
        my ( $self, $ident, $number ) = @_;

        my $subname = $_;    # Requested subroutine name is passed via $_

        return sub { return $feedPP{ ident $self}->$subname; };
    }
}

1;

package XML::FeedPP::RSS::Item::MediaWords;

use base 'XML::FeedPP::RSS::Item';
use Perl6::Say;
use Data::Dumper;

sub create_wrapped_rss_item
{
    my $package = shift;
    my $obj     = shift;

    $DB::single = 1;

    my $debug = Dumper( $obj );

    #say $debug;

    bless $obj, $package;

    return $obj;
}

sub description
{
    my $self = shift;

    my $description = $self->SUPER::description( @_ );

    my $content;
    $content = $self->get( 'content:encoded' );

    return $description || $content;
}

1;
