#!/usr/bin/perl

use HTML::Form;
use HTTP::Request::Common;
use Getopt::Long;
use strict;
use warnings;

require LWP::UserAgent;

my $website;
GetOptions('help|?' => sub { Help() },
            'p' => \$website);
$website = $ARGV[0] || "ERROR";
foreach my $n (1 .. $#ARGV)
{
    $website = $website .'+'. $ARGV[$n];
}

my $ua = LWP::UserAgent->new;
$ua->timeout(0);
$ua->env_proxy;

#http://www.willmaster.com/library/manage-forms/using_perl_to_submit_a_form.php
# Specify the information to post, the form field name on 
#   the left of the => symbol and the value on the right.

# Post the information to the CGI program.
my $Page = $ua->request(GET "https://www.google.com");

# Print the returned page (or an error message).
if ($Page->is_success)
{ 
    print "Success\n";
    system("firefox https://www.google.com/?gws_rd=ssl#q=$website");
}
else { print $Page->message; print "\n\nNo Dice\n";}


###########
# Methods #
###########

sub Help
{
   print STDERR <<"End-Of-Help";
Usage:
   google.pl <google search>
   google.pl -p <page to search for>

Options:

Any of these options will display the help pages:
   -?  -h  -H  /?  /h  /H

End-Of-Help

    exit(1);
}