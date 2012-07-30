package ExpenseTracker::Controllers::Login;
use Mojo::Base 'ExpenseTracker::Controllers::Base';

use Digest::MD5 qw(md5 md5_hex);

sub login {
  my $self = shift;
  
  $self->render;
}

sub auth {
  my $self = shift;
  if (
    $self->authenticate( $self->param('username'), $self->param('password') )
    )
  {
    $self->redirect_to('/');
  }
  else {
    push(
      @{ $self->session->{error_messages} },
      'Username and password don\'t match!'
    );
    $self->redirect_to( $self->url_for( 'login' ) );
  }

  return;
}


sub logout {
  my $self = shift;

  $self->session( expires => 1 );

  push(
    @{ $self->session->{success_messages} },
    'Good bye, hope to see you soon!!'
  );
  $self->redirect_to('/');

  return;
}

1;

__END__
=pod
 
=head1 NAME
ExpenseTracker::Controllers::Login - Controller responsible for login/logout operations


=cut