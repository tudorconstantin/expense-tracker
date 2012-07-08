package ExpenseTracker::Controllers::Base;

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Controller';



sub create{
  my $self = shift;
  
  my $result;
  
  return $self->render_json( $result );
}

sub update{
  my $self = shift;
  
  my $result;
  
  return $self->render_json( $result );
}

sub list{
  my $self = shift;  
    
  my $result;
  
  return $self->render_json( $result );
}


sub show{
  my $self = shift;
  
  my @result = $self->app->model
      ->resultset( $self->{resource} )
      ->search_rs(
          { id => $self->param('id') },
          { result_class => 'DBIx::Class::ResultClass::HashRefInflator' },
      )
      ->all;  
  
  return $self->render_not_found if ( scalar( @result == 0 ) );
  return $self->render_json( [ @result ] );
}

sub remove{
  my $self = shift;
  
  my $result;
  
  return $self->render_json( $result );
}
1;