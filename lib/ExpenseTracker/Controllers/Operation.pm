package ExpenseTracker::Controllers::Operation;
use Mojo::Base 'ExpenseTracker::Controllers::Base';

sub new{
  my $self = shift;
  
  my $obj = $self->SUPER::new(@_);
  
  $obj->{resource} = 'ExpenseTracker::Models::Result::Operation';

  return $obj;
  
}

sub list_by_category{
  my ( $self ) = @_;

  my $result_rs = $self->app->user->categories( { 'me.id' => $self->param('category_id') } )->search_related_rs( 'operations_category' )->search_related_rs( 'operation' );
  
  $result_rs->result_class('DBIx::Class::ResultClass::HashRefInflator');     

  my @expenses = $result_rs->all ;
  return $self->render_not_found() if scalar @expenses == 0 ;
  return $self->render_json( [ @expenses ] );  
  
}


1;