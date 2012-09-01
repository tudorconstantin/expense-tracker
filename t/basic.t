use Mojo::Base -strict;

use Test::More tests => 4;
use Test::Mojo;

use_ok 'ExpenseTracker';

my $t = Test::Mojo->new('ExpenseTracker');
$t->get_ok('/')->status_is(200)->content_like(qr/Expense/i);
