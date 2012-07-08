#!/usr/bin/env perl

use 5.010;

use strict;
use warnings;

# "Son, when you participate in sporting events,
#  it's not whether you win or lose, it's how drunk you get."
use ExtUtils::MakeMaker;

my ($mm) = $ExtUtils::MakeMaker::VERSION =~ /^([^_]+)/;

# We only use core modules, so you shouldn't have to install anything besides
# Perl 5.8.7!
WriteMakefile(
  NAME         => 'Expense Tracker',
  VERSION      => '0.1',
  ABSTRACT     => 'POC for Mojolicious and Backbone.js',
  AUTHOR       => 'Tudor Constantin & Andrei Ursan',

  ($mm < 6.3002 ? () : ('LICENSE' => 'artistic_2')),

  ( $mm < 6.46
    ? ()
    : (
      META_MERGE => {
        requires  => {perl => '5.0010'},
        resources => {
          homepage    => 'https://github.com/tudorconstantin/expense-tracker',
          license     => 'http://dev.perl.org/licenses/',          
          repository  => 'http://github.com/tudorconstantin/Mojolicious-Boilerplate',
          bugtracker  => 'https://github.com/tudorconstantin/expense-tracker/issues'
        },
        no_index => {directory => [qw/t/]}
      },
      META_ADD => {
        build_requires     => {},
        configure_requires => {},        
      },
    )
  ),

  EXE_FILES => ['script/expense-tracker'],
  PREREQ_PM => {
    'Mojolicious'                     => 0,
    'Mojolicious::Plugin::YamlConfig' => 0,
    'YAML'                            => 0,
    'YAML::XS'                        => 0,
    'File::Find'                      => 0,
    'Test::BDD::Cucumber'             => 0,
    'FindBin::libs'                   => 0,
    #'DBIx::Class'                     => '0.08196',
    'DBIx::Class'                     => 0,
    #'DBI'                             => '1.622',
    'DBI'                             => 0,
    #'DBD::SQLite'                     => '1.37',
    'DBD::SQLite'                     => 0,
  },
  test => {TESTS => 't/*.t t/*/*.t'}
);

# Using Perl 5.8.x is a bad idea though
warn <<'EOF' unless $] >= 5.010;

*******************************************************************************
You are using Perl 5.8, a version that has reached the end of its life a few
years ago and which is no longer getting updated by the community.
It contains very serious flaws, especially around the regular expression
engine, that will never get fixed and are likely to put your applications at
risk.
While your operating system vendor might keep it compiling on their platform,
they will not fix these issues.

Therefore we highly recommend that you upgrade as soon as possible!
*******************************************************************************

EOF
