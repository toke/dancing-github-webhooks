# What is this?

I use this as an Webhook endpoint for getting notified by [Github](https://github.com/)
when a repository is changed. Used for http://toke.de the code of this website is also on
[GitHub](https://github.com/toke/toke.de).

[Read more](http://toke.de/blog/perl/2012/02/09/how-i-post/)

## Installation

     cpan Dancer
     cpan App::gh::Git
     perl bin/app.pl

[![Build Status](https://secure.travis-ci.org/toke/dancing-github-webhooks.png)](http://travis-ci.org/toke/dancing-github-webhooks)

## Deployment
I use Perlbal...
`cpan IO::AIO Perlbal`

