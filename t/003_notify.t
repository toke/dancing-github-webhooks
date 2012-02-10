use strict;
use warnings;
use Test::More;

use GithubHook;
use Dancer::Test;

$GithubHook::config = {
    test => {
        run => "echo ok",
    },
};

response_status_is [GET => '/test'], 404, "Not found";
response_status_is [GET => '/notify/test'], 405, "Method not allowed";
response_status_is [POST => '/notify/test1'], 404, "Not found 2";
response_status_is [POST => '/notify/test'], 415, "Missing Payload";
