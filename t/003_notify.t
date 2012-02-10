use strict;
use warnings;
use Test::More;

use GithubHook;
use Dancer::Test;


response_status_is [GET => '/test'], 403, "Not for you\n";
