package GithubHook;
use Dancer ':syntax';
use Git;

our $VERSION = '0.1';


use constant UNSUPPORTED_MEDIA_TYPE => '415';

my $config = {
    "toke.de" => {
        run => "/srv/staging/bin/updateblog.sh toke.de",
        repository => "/srv/staging/toke.de",
    },
    "tor.toke.de" => {
        run => "/srv/staging/bin/updateblog.sh tor.toke.de",
        repository => "/srv/staging/tor.toke.de",
    },

};

set content_type 'text/plain';

prefix '/notify' => sub {

    get '/a/*' => sub {
        header 'Allow' => 'POST';
        status '405';
        "Not for you\n";
    };

    get '/:project' => sub {
        if (not defined $config->{params->{project}}) {
            status 'not_found';
            return "No such project:
            ".params->{project}."\n";
        }
        # Read the configuration for that repo
        my $repo_config = $config->{params->{project}};
        my $repo;
        if (defined $repo_config) {
            $repo = Git->repository(Directory => $repo_config->{repository});
            my ($type, $lastrev) = split(" ", $repo->command_oneline( [ 'log', '-n1' ], STDERR => 0 ));
            header 'Content-Type' => 'text/json';
            status 200;
            return to_json({latest_rev => $lastrev, type => $type});
        } else {
            status 'not_found';
        }
    };

    post '/:project' => sub {
        if (not defined $config->{params->{project}}) {
            status 'not_found';
            return "No such project:
            ".params->{project}."\n";
        }

        # payload is mandatory
        my $payload = params->{'payload'};
        if (not defined $payload) {
            status UNSUPPORTED_MEDIA_TYPE;
            return "No payload\n";
        }

        my $json = from_json($payload);
        my $repo = $json->{repository};

        # Read the configuration for that repo
        my $repo_config = $config->{$repo->{name}};
        if (defined $repo_config) {
            eval {
                system $repo_config->{run};
            };
        }

        return "OK";
    };
};


true;
