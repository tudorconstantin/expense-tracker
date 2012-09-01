use Mojo::Base -strict;

use FindBin::libs;

use Test::More tests => 5;
use Test::Mojo;

use_ok 'ExpenseTracker';

my $t = Test::Mojo->new('ExpenseTracker');
ok($t, 'Created the test object');
$t->get_ok('/')->status_is(200)->content_like(qr/Expense/i);

done_testing();