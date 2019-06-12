#!/usr/bin/env perl

=head1 perl-inline-modules.pl

 This script is a prototype and template for creating Perl scripts that use inline modules.

 It is necessary to influence Perl to compile the modules before the rest of the script.

 Some other unusual steps must be taken as well.  Please read comments in the script.



=cut 
  

use warnings;
# with inline modules containing function prototypes, it is necessar
# to tell warnings not to complain about prototypes
# comment out the following line to see why
no warnings 'prototype';

use strict; 

Pkgtest->import( qw(&getTestVar &squared));
Util->import( qw(&random));

print '4 squared: ', squared(4),"\n";
print 'Pkgtest::getTestVar: ' , Pkgtest::getTestVar('string2'),"\n";
print 'Pkgtest::getTestVar: ' , getTestVar('string9'),"\n";

print 'Random number: ', random(), "\n";

# End of main script

# without the BEGIN this script will not work without including the 'Pkgtest:' prefixes
# this BEGIN is necessary for the variables to be available to the functions
# when the package is included inline

BEGIN {

=head1 Pkgtest Module

 The Pkgtest Module demonstrates the use of an inline module in a script.

 In the main script you may manually import the functions so they may be called without the module name

 For instance:

 Not this:
   use Pkgtest;

 'Use' will not work for an inline module.

 Do this:
   Pkgtest->import( qw(&getTestVar &squared));

 
 The contents of each module must be enclosed in a BEGIN{} block.
 If this is not done, variables defined in the module will not be available to the functions within the module.
 When a module is loaded with 'Use', it is compiled before the main script.
 As this demo has modules inline with the script, that cannot be done, so we have to tell Perl to compile the
 prior to compiling and executing the script.

 A BEGIN{} block could be placed around the contents of each module.
 It is simpler however to just put them all within a single BEGIN{}

=cut


package Pkgtest;


use Data::Dumper;

use Exporter qw(import);
our $VERSION=0.1;
# do not export variable names
# use a hash or something and return with an index
# exporting variables may not even work (  perldoc Exporter to see that in print )
our @EXPORT = qw(&getTestVar &squared $t);
our @ISA=qw(Exporter);


sub getTestVar($);

my %vars = (
	'string1' => 'this is string 1',
	'string2' => 'this is string 2',
	'string3' => 'this is string 3',
	'string4' => 'this is string 4',
	'string5' => 'this is string 5',
);


sub getTestVar($) {
	my ($key) = @_;

	if ( $vars{$key}) { return $vars{$key}}
	else{ return 'no such value' }
}

sub squared {
	return $_[0] * $_[0];
}


=head1 Util Module

 The Util module supplies the random() function.
 random() returns a number between 0 and 100

 Util is use to demonstrate the use of a 2nd inline Module in a script

=cut 

package Util;

use Exporter qw(import);
our $VERSION=0.1;
# do not export variable names
# use a hash or something and return with an index
# exporting variables may not even work (  perldoc Exporter to see that in print )
our @EXPORT = qw(&random);

sub random {
	return int(rand(100));
}

}


