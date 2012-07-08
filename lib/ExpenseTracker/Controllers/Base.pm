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
  
  my $result = { resource => $self->{resource} };
  
  return $self->render_json( $result );
}

sub remove{
  my $self = shift;
  
  my $result;
  
  return $self->render_json( $result );
}
1;