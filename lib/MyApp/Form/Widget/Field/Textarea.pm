package MyApp::Form::Widget::Field::Textarea;
# ABSTRACT: textarea rendering widget

use Moose::Role;
use namespace::autoclean;
use HTML::FormHandler::Render::Util ('process_attrs');

sub render {
    my $self = shift;
    my $result = shift || $self->result;
    my $fif  = $self->html_filter($result->fif);
    my $id   = $self->id;
    my $cols = $self->cols || 10;
    my $rows = $self->rows || 5;
    my $name = $self->html_name;

    my $output =
        qq(<textarea name="$name" id="$id")
        . process_attrs($self->attributes)
        . qq( rows="$rows" cols="$cols">$fif</textarea>);

    return $self->wrap_field( $result, $output );
}

1;
