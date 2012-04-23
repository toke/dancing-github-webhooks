use Test::More tests => 2;
use strict;
use warnings;

# the order is important
use GithubHook;
use Dancer::Test;

route_exists [GET => '/notify/test'], 'a route handler is defined for /';
response_status_is ['GET' => '/'], 404, 'response status is 400 for /';
