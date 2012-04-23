use strict;
use warnings;

BEGIN {
    use Test::More tests => 5;
    use namespace::clean qw( pass );
}

#use Dancer qw( :syntax );
use GithubHook;
Dancer::set  environment => "testing";
Dancer::Config->load;
use Dancer::Test;


response_status_is [GET => '/notify/abc'], 404, "Not found";
SKIP:  {
    skip "Problems loading matching environment", 4;
    response_status_is [GET => '/notify/toke.de'], 200, "Method not allowed";
    response_status_is [GET => '/notify/test'], 200, "Method not allowed";
    response_status_is [POST => '/notify/test1'], 404, "Not found 2";
    response_status_is [POST => '/notify/test'], 415, "Missing Payload";
}
done_testing;
