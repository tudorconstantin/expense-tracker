#!perl

 use strict;
 use warnings;

 use Test::More;
 use Test::Mojo;
 use Test::BDD::Cucumber::StepFile;
 use Method::Signatures;
 
 Given qr/a mojo test object for the "(.+)" application/, func ($c) {
  use_ok( $1 );
  my $tm = Test::Mojo->new( $1 );
  
  # Allow redirects
  $tm->ua->max_redirects(5);
  
  ok( $tm, "Object created" );
  $c->stash->{'feature'}->{'tm'} = $tm;
  ok( $c->stash->{'feature'}->{'tm'}, "Got our Test::Mojo object" );
 };
 
 When qr/I go to "(.+)"/, func ($c) {
    # $1 matches a word - that word is a url name and passed as param to the url_for method
    # thus, we should get a named url
    $c->stash->{'feature'}->{'tm'}->get_ok(  $c->stash->{feature}->{tm}->app->url_for( $1 ) );
 };
 
 Then qr/I should see the "(.+)"\s+(.+)$/, func ($c) {
    if ( $2 eq 'url' ){
      use_ok('Mojo::DOM');
      my $dom = Mojo::DOM->new($c->stash->{'feature'}->{'tm'}->tx->res->body());
      foreach my $link ( $dom->find('a[href]')->each ) {         
        pass("Found URL with text $1") and return 1 if $link->text eq $1;        
      }
      fail( "I have not seen $1 of type $2" );
    } elsif( $2 eq 'text'){
      ok( $c->stash->{'feature'}->{'tm'}->content_like(qr/$1/) );
    } else {
      pending( "I don't know how to find $2" );
    } 
    
 }