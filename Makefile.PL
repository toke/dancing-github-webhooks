use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'dancing-github-webhooks',
    AUTHOR              => q{Thomas Kerpe <toke@toke.de>},
    VERSION_FROM        => 'lib/GithubHook.pm',
    ABSTRACT            => 'Github webhook endpoint',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE' => 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'YAML'       => 0,
        'Git'        => 0,
        'Dancer'     => 1.3091,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'dancing-github-webhooks-*' },
);
