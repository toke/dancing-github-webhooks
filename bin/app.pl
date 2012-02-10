#!/usr/bin/env perl
use Dancer;

our $env->{SERVER_NAME} //= $env->{HTTP_HOST};

load_app 'GithubHook', prefix => "/api";
dance;
