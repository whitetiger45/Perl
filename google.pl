#!/usr/bin/perl

use HTML::Form;
use HTTP::Request::Common;
use Getopt::Long;
use strict;
use warnings;
#use Win32::OLE; #this is not needed with Linux OS

require LWP::UserAgent;

my $website = "Error";
GetOptions('help|?' => sub { Help() },
            'p' => \$website);
$website = $ARGV[0] || "ERROR";

#system("start http://pnlv6111:8080/cgi-bin/assemBuildTool.cgi");

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
    print "\nSuccess\n";
    #system("start https://www.google.com/search?q=$website");
    system("firefox https://www.google.com/search?q=$website"); 
}
else { print $Page->message; print "\n\nNo Dice\n";}


###########
# Methods #
###########

sub Help
{
   print STDERR <<"End-Of-Help";
Usage:
    **windows**
    google.pl <google search>
    google.pl -p <page to search for>
============================================
    **linux**
    ./google.pl -p <google search> **linux**
    ./google.pl <google search> 


Options:

Any of these options will display the help pages:
   -?  -h  -H  /?  /h  /H

End-Of-Help

    exit(1);
}