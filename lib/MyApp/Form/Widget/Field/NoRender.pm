package MyApp::Form::Widget::Field::NoRender;
# ABSTRACT: no rendering widget

use Moose::Role;

sub render { '' }

use namespace::autoclean;
1;
