#
#===============================================================================
#
#         FILE: IpAddress.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Thomas Kerpe (), thomas.kerpe@1und1.de
#      COMPANY: 1&1 Internet AG
#      VERSION: 1.0
#      CREATED: 03/07/2013 08:53:38 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

package IpAddress;
use Dancer;


get '/foo' => sub {
        sprintf ('{"remote_ip": "%s"}', request->env()->{HTTP_X_FORWARDED_FOR});
};

1;
