package MyApp::Form::Widget::Wrapper::Table;
# ABSTRACT: wrapper class for table layout

use Moose::Role;
with 'MyApp::Form::Widget::Wrapper::Base';
use HTML::FormHandler::Render::Util ('process_attrs');

sub wrap_field {
    my ( $self, $result, $rendered_widget ) = @_;

    return $rendered_widget if ( $self->has_flag('is_compound') && $self->get_tag('no_compound_wrapper') );

    my $output = "\n<tr" . process_attrs($self->wrapper_attributes($result)) . ">";
    if ( $self->has_flag('is_compound') ) {
        $output .= '<td>' . $self->render_label . '</td></tr>';
    }
    elsif ( !$self->has_flag('no_render_label') && length( $self->label ) > 0 ) {
        $output .= '<td>' . $self->render_label . '</td>';
    }
    if ( !$self->has_flag('is_compound') ) {
        $output .= '<td>';
    }
    $output .= $rendered_widget;
    $output .= qq{\n<span class="error_message">$_</span>} for $result->all_errors;
    if ( !$self->has_flag('is_compound') ) {
        $output .= "</td></tr>\n";
    }
    return $output;
}

use namespace::autoclean;
1;
