package GithubHook;
use Dancer ':script';
use App::gh::Git;

our $VERSION = '0.1';


use constant UNSUPPORTED_MEDIA_TYPE => '415';

set content_type 'text/plain';

prefix '/notify' => sub {

    get '/:project' => sub {
        header 'Cache-Control' => 'no-cache';
        if (not defined config->{projects}->{params->{project}}) {
            header 'Content-Type' => 'text/json';
            status 'not_found';
            return '{"error": "Project '.params->{project}.' not found"}';
        }
        # Read the configuration for that repo
        my $repo_config = config->{projects}->{params->{project}};
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
        if (not defined config->{projects}->{params->{project}}) {
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
        my $repo_config = config->{projects}->{params->{project}};
        if (defined $repo_config) {
            eval {
                system $repo_config->{run};
            };
        }

        return "OK";
    };
};


true;
