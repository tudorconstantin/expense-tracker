package ExpenseTracker::Controllers::Site;
use Mojo::Base 'Mojolicious::Controller';

sub welcome{
  my $self = shift;
  
  return $self->render( message => 'Hello World' );
}

1;

__END__
=pod
 
=head1 NAME
ExpenseTracker::Controllers::Site

=cut