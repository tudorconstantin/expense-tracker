package ExpenseTracker;
use Mojo::Base 'Mojolicious';
use ExpenseTracker::Models;
use ExpenseTracker::Routes;

# ABSTRACT: Demo app for showing the synergy between perl and javascript

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
  #db connect  
  my $mode = lc( $ENV{MOJO_MODE} || 'development' );
  
  if ( !$self->can('model') ) {
    ref($self)->attr(
      'model' => sub {
        return ExpenseTracker::Models->connect(
          $config->{database}->{ $mode }->{dsn},
          $config->{database}->{ $mode }->{user},
          $config->{database}->{ $mode }->{password},
        );
      }
    );
  }
  
  $self->hook(after_static_dispatch => sub {
    my $c = shift;
    
    $c->session->{_menu} = defined($c->session->{user})
                ? $c->app->{config}->{app_menu}->{$c->session->{user}->{user_type} }
                : $c->app->{config}->{app_menu}->{anonymous} ;
   });  
   
  # Routes
  my $r = $self->routes;
  
  #set location for controllers
  $r->namespace('ExpenseTracker::Controllers');
  
  $r->route('/')->to("site#welcome");
  
  my $api_routes = $r->route('/api')->over( authenticated => 1 );

  my $routes_params = {
    app_routes            => $r,
    api_base_url          => '/api',
    controllers_namespace => 'ExpenseTracker::Controllers',
    resource_names        => [ qw/category operation currency operations_category / ],
  };
  
  ExpenseTracker::Routes->create_routes( $routes_params );
  
}

sub user{
  my $self = shift;

  return unless $self->{uid};
  return $self->{user} if (defined($self->{user}) and $self->{user}->id() == $self->{uid} );
  $self->{user} = $self->model->resultset('User')->find( $self->{uid} );
  return $self->{user};
  
}

1;
