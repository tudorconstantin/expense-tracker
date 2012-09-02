#!perl

use strict;
use warnings;

use Test::More; 
use Test::Mojo;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;
use Data::Dumper;
use Lingua::EN::Inflect::Phrase qw/to_S/;
  
When qr/I log in with username "(.+?)" and password "(.+?)"/, func($c) {
  my ($username, $password) = ( $1, $2 );  
  
  $c->stash->{'feature'}->{'tm'}->post_form_ok(
  $c->stash->{'feature'}->{'tm'}->app->url_for('authenticate_html'),
  {
    username => $username,
    password => $password,
  }  
  );
};

Given qr/the following ([^\s]+)/, func($c){
  my $resource_name = $1;
  
  $c->stash->{scenario}->{resource_name} = $resource_name;
  $c->stash->{scenario}->{resource_data} = $c->data;
  $c->stash->{scenario}->{resource_api_url} = sprintf('%s/%s',
      $c->stash->{'feature'}->{'tm'}->app->{config}->{api}->{base_url},
      $c->stash->{scenario}->{resource_name},
  );
  
};

When qr/I create them through the REST API/, func($c){
  #print "CURRENT RESOURCE ".$c->stash->{scenario}->{resource_name}."\n";
  if ( $c->stash->{'feature'}->{users_created} and $c->stash->{scenario}->{resource_name} eq 'users' ) {
    #print "USERS CREATED - SHOULD RETURN";
    pass('Users are already created for this feature') ;
    return;
  }
  
  foreach my $resource_data ( @{ $c->stash->{scenario}->{resource_data} } ) {  
    $c->stash->{'feature'}->{'tm'}->post_json_ok( $c->stash->{scenario}->{resource_api_url}, $resource_data )->status_is(200);
  };
  $c->stash->{'feature'}->{users_created} = 1 if $c->stash->{scenario}->{resource_name} eq 'users';
};

Then qr/I should be able to list their ([^\s]+)/, func($c){
  my $col_name = Lingua::EN::Inflect::Phrase::to_S( $1 ) || 'name';
  
  #print "RECEIVING FROM url:".$c->stash->{scenario}->{resource_api_url}." as user: ".$c->stash->{'feature'}->{'tm'}->app->user->username."| with id: ".$c->stash->{'feature'}->{'tm'}->app->user->id."\n" if $c->stash->{scenario}->{resource_name} eq 'categories';
  my $list_of_resources = $c->stash->{'feature'}->{'tm'}->ua->get( $c->stash->{scenario}->{resource_api_url} )->res->json;
  
  #print"RESPONSE: ".Dumper($list_of_resources) if $c->stash->{scenario}->{resource_name} eq 'categories';  
  ok($list_of_resources, sprintf('Received a list of %s from %s', $c->stash->{scenario}->{resource_name}, $c->stash->{scenario}->{resource_api_url}));
  
  
  my $received_column_values = [];
  @{ $received_column_values } = map { $_->{$col_name} } @{ $list_of_resources };
  
  my @wanted_column_data = map { $_->{ $col_name } } @{ $c->stash->{scenario}->{resource_data} };  
  
  foreach my $wanted_to_be_created ( @wanted_column_data ){
    cmp_ok( $wanted_to_be_created, '~~', $received_column_values, "$wanted_to_be_created was created");
  }
  
  #keep only the resources that were created by us
  @{ $c->stash->{scenario}->{list_of_resources} } = grep { $_->{ $col_name } ~~ [ @wanted_column_data ] } @$list_of_resources;
};

Then qr/I should be able to get their ([^\s]+)/, func($c){
  my $col_name = Lingua::EN::Inflect::Phrase::to_S( $1 ) || 'id';

  foreach my $created_resource ( @{ $c->stash->{scenario}->{list_of_resources} } ){  
    my $resource_url = sprintf('%s/%s', $c->stash->{scenario}->{resource_api_url}, $created_resource->{id} );
    
    #GET /api/currency/23
    my $received_from_api = $c->stash->{'feature'}->{'tm'}->ua->get( $resource_url )->res->json;
    
    cmp_ok( ref( $received_from_api ), 'eq', 'HASH', "Got a valid hashref from $received_from_api" );    
    cmp_ok( $received_from_api->{ $col_name }, '>', 0, sprintf("%s has %s > 0", $c->stash->{scenario}->{resource_name}, $col_name ) );
  }
};

Then qr/I should be able to delete them/, func($c){
  print "DELETING: ".Dumper($c->stash->{scenario}->{list_of_resources}) if $c->stash->{scenario}->{resource_api_url} =~ 'categories';
  foreach my $created_resource ( @{ $c->stash->{scenario}->{list_of_resources} } ){
    my $delete_url = sprintf( '%s/%s', $c->stash->{scenario}->{resource_api_url}, $created_resource->{id} );
    
    $c->stash->{feature}->{tm}->delete_ok( $delete_url )->status_is( 200 );
  }
};

Then qr/I should be able to delete the above by ([^\s]+)/, func($c){
  my $col_name = $1;  
  
  #print "--------------------".Dumper($c->stash->{scenario}->{resource_data}) if $c->stash->{scenario}->{resource_name} eq 'categories';
  foreach my $finder ( @{ $c->stash->{scenario}->{resource_data} } ){
    my $wanted_resource = _find_resource_by( $c, {
        col_name  => $col_name,
        value     => $finder->{ $col_name },
    } );
    
    cmp_ok( ref $wanted_resource, 'eq', 'HASH', "Found res with id ".( $wanted_resource->{id} || 'not_found')." by $col_name ". $finder->{ $col_name } );
    
    fail( sprintf( 'Could not find %s with %s %s', $c->stash->{scenario}->{resource_name}, $col_name, $finder->{ $col_name } ) ) if ref $wanted_resource ne 'HASH';
    
    my $delete_url = sprintf( '%s/%s', $c->stash->{scenario}->{resource_api_url}, $wanted_resource->{id} );
    $c->stash->{feature}->{tm}->delete_ok( $delete_url )
      ->status_is( 200 );
  }
  
};

Then qr/I should not be able to find them by ([^\s]+)/, func($c){
 my $col_name = $1;
 my $list_of_resources;
  foreach my $finder ( @{ $c->stash->{scenario}->{resource_data} } ){ 
    
    if ( $c->stash->{'feature'}->{'tm'}->ua->get( $c->stash->{scenario}->{resource_api_url} )->res->code == 404 ){
      pass("Empty list - no ".$c->stash->{scenario}->{resource_name}." exists \n");
      return;
    };
    
    $list_of_resources = $c->stash->{'feature'}->{'tm'}->ua->get( $c->stash->{scenario}->{resource_api_url} )->res->json;
    if ( !( $finder->{ $col_name } ~~ [ map { $_->{$col_name} } @{$list_of_resources} ] ) ) {
      pass(sprintf("Success: %s NOT found with $col_name %s", $c->stash->{scenario}->{resource_name}, $finder->{ $col_name } ) );
    } else {
      fail( sprintf(" FOUND %s with $col_name %s", $c->stash->{scenario}->{resource_name}, $finder->{ $col_name } ) );
    }
    
  }
};


sub _find_resource_by{
  my $c = shift;
  my $args = shift;  

  my $wanted_resource;  
  
  my $list_of_resources = $c->stash->{'feature'}->{'tm'}->ua->get( $c->stash->{scenario}->{resource_api_url} )->res->json;
  ok($list_of_resources, sprintf('Received a list of %s from %s', $c->stash->{scenario}->{resource_name}, $c->stash->{scenario}->{resource_api_url}));
  
  foreach my $resource ( @{ $list_of_resources } ) {
    #print  sprintf("|%s|%s|%s|\n", $resource->{ $args->{col_name} }, $args->{value}, ( $resource->{ $args->{col_name} } eq $args->{value} ) );  
    next if ( $resource->{ $args->{col_name} } ne $args->{value} );    
    $wanted_resource = $resource;
    last;

  };
  
  return $wanted_resource;
}