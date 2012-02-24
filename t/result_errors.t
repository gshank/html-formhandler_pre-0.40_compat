use strict;
use warnings;
use Test::More;

use HTML::FormHandler::I18N;
$ENV{LANGUAGE_HANDLE} = HTML::FormHandler::I18N->get_handle('en_en');

{
    package Test::Form;
    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler';
    with 'MyApp::Form::Widget::Form::Simple';
    has '+widget_name_space' => ( default => sub {['MyApp::Form::Widget']} );

    has_field 'foo';
    has_field 'foo_required' => ( required => 1 );
}

my $form = Test::Form->new;
ok( $form, 'got form');
my $result = $form->run( params => { foo => 'bar' } );
ok( !$result->validated, 'did not validate' );
ok( $result->field('foo_required')->has_errors, 'foo has error' );
ok( $result->has_errors, 'result has errors' );
is( $result->num_errors, 1, 'number of errors is correct' );
is( $result->errors->[0], 'Foo required field is required', 'result field has error' );
is( $result->field('foo_required')->render, '
<div class="error"><label for="foo_required">Foo required: </label><input type="text" name="foo_required" id="foo_required" value="" />
<span class="error_message">Foo required field is required</span></div>
', 'error field has error' );


done_testing;
