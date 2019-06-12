<html>
<body>

  this is a test
  
<h2>perl-inline-modules.pl</h2>
<pre>
     This script is a prototype and template for creating Perl scripts that use inline modules.

     It is necessary to influence Perl to compile the modules before the rest of the script.

     Some other unusual steps must be taken as well.  Please read comments in the script.
</pre>

<h2>Pkgtest Module</h2>
<pre>
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
</pre>

<h2>Util Module</h2>
<pre>
     The Util module supplies the random() function.
     random() returns a number between 0 and 100

     Util is use to demonstrate the use of a 2nd inline Module in a script
</pre>

