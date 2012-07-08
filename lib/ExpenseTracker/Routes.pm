package ExpenseTracker::Routes;

use Mojo::Util qw/camelize/;

sub create_routes{
  my ( $self, $params ) = @_;

    #use Data::Dumper;
    #warn "api routes".Dumper($self, $r, $controllers_namespace, $resource_names );
    
  $params->{app_routes}->add_shortcut(resource => sub {
    my ($r, $name ) = @_;
    
    # Generate "/$name" route
    my $resource = $r->route( ( $params->{api_base_url} || '' )."/$name" )->to("$name#");

    # Handle POST requests - creates a new resource
    $resource->post->to('#create')->name("create_$name");

    # Handle GET requests - lists the collection of this resource
    $resource->get->to('#list')->name("list_$name");

    $resource = $r->route( ( $params->{api_base_url} || '' )."/$name/:id" )->to("$name#");
    
    $resource->get->to('#show')->name("show_$name");
    $resource->delete->to('#remove')->name("delete_$name");
    $resource->put->to('#update')->name("update_$name");
    
    
    return $resource;
  });
  
  foreach my $resource ( @{ $params->{ resource_names } } ){
    $params->{app_routes}->resource( $resource );
  }
}

sub _add_routes_authorization {
  my $self = shift;

  # foreach my $user_type ( qw(client cashier provider admin) ){
  $self->routes->add_condition(
    authenticated => sub {
      my ( $r, $c, $captures, $authenticated ) = @_;
      
      # It's ok, we know him
      return 1 if (
            (  $authenticated and  defined( $self->user ) )
         or ( !$authenticated and !defined( $self->user ) )
      );
      
      return;
    }
  );

  return;
}

1;