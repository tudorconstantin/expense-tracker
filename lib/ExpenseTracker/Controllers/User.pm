package ExpenseTracker::Controllers::User;
use Mojo::Base 'ExpenseTracker::Controllers::Base';

sub new{
  my $self = shift;
  
  my $obj = $self->SUPER::new(@_);
  
  $obj->{resource} = 'ExpenseTracker::Models::Result::User';

  return $obj;
  
}

1;

__END__
=pod
 
=head1 NAME
ExpenseTracker::Controllers::User - Controller responsible for the User resource


=cut