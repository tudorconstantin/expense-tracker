package ExpenseTracker;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->secret("Very well hidden secret");

  # Everything can be customized with options
  my $config = $self->plugin( yaml_config => {
        file      => 'conf/config.yaml',
        stash_key => 'conf',
        class     => 'YAML::XS'
  });
                                
  $self->{config} = $config;

  $self->hook(after_static_dispatch => sub {
    my $c = shift;
    
    $c->session->{_menu} = defined($c->session->{user})
                ? $c->app->{config}->{app_menu}->{$c->session->{user}->{user_type} }
                : $c->app->{config}->{app_menu}->{anonymous} ;
   });  
   
  # Routes
  my $r = $self->routes;
  
  
}


1;
