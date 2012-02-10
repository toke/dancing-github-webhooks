package GithubHook;
use Dancer ':syntax';

our $VERSION = '0.1';


use constant UNSUPPORTED_MEDIA_TYPE => '415';

my $config = {
    "toke.github.com" => {
        run => "/home/toke/bin/updateblog.sh",
    },
};

set content_type 'text/plain';

prefix '/notify' => sub {

    get '/*' => sub {
        header 'Allow' => 'POST';
        status '405';
        "Not for you\n";
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
        #my $commits = $json->{commits};

        # Read the configuration for that repo
        my $repo_config = $config->{$repo->{name}};
        if (not defined $repo_config) {
            print NO_CONFIG_MESSAGE;
            #exit 0;
        } else {
            eval {
                system $repo_config->{run};
            };
        }

        return "OK";
    };
};


true;
