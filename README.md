RAppArmor
=========

The R package RAppArmor interfaces to a number of security related methods in the Linux kernel. It supports the following functionality:

 * loading and changing AppArmor profiles and hats to enforce advanced security policies
 * setting RLIMIT values to restrict usage of memory, cpu, disk, etc
 * setting the process priority
 * switching uid/gid of the current process
 * setting the affinity mask of the current process
 * calling an R command with a 'timeout' to kill if it does not return with in n seconds
 * doing all of the above dynamically for a single R call using the `eval.secure` function  
 
This can be useful for example if to host a public service for users to run R code, or if you are paranoid about running contributed code on your machine. 


Documentation / Tutorials
-------------------------

The best sources to learn about RAppArmor:

 * [JSS paper](http://www.jstatsoft.org/v55/i07/) *(recommended)* - High level introduction to most important concepts and features
 * [PDF manual](http://cran.r-project.org/web/packages/RAppArmor/RAppArmor.pdf) - Auto generated PDF documentation.
 * [Video Tutorials](http://www.youtube.com/playlist?list=PL3ZKTMqqbMktzcWjXuQCWOYc-fMROs3cf&feature=view_all) 3 short (10min) tutorials demonstrating core functionality.

OS Support
----------

The package has been successfully build on the following Linux distributions:

* Ubuntu 12.04  and up *(recommended)*
* Debian 7 and up - [install notes](https://github.com/jeroenooms/RAppArmor/blob/master/Debian-Wheezy.txt)
* OpenSuse 12.1 and up - [install notes](https://github.com/jeroenooms/RAppArmor/blob/master/OpenSuse.txt)

For Ubuntu there is a convenient installation package available through launchpad (see below). 
For Debian/OpenSuse the package needs to be built from source (see install notes).

Installation on Ubuntu
----------------------

On Ubuntu the package is easily installed through launchpad (recommended). There are two repositories: 

 * [opencpu/rapparmor](https://launchpad.net/~opencpu/+archive/rapparmor) - build for version of R that ships with Ubuntu.
 * [opencpu/rapparmor-dev](https://launchpad.net/~opencpu/+archive/rapparmor-dev) - build for R 3.0.0.
 
To install, run: 

    sudo add-apt-repository ppa:opencpu/rapparmor-dev
    sudo apt-get update
    sudo apt-get install r-cran-rapparmor
    
To uninstall the r-cran-rapparmor package (also recommended before upgrading):

    sudo apt-get purge r-cran-rapparmor
    sudo ppa-purge ppa:opencpu/rapparmor-dev    

Alternatively, to manually install RAppArmor on Ubuntu:

    #Install dependencies:
    sudo apt-get install r-base-dev libapparmor-dev apparmor-utils

    #Download and install the package:
    sudo R -e 'install.packages("RAppArmor", repos="http://cran.r-project.org")'
    
    #Install the profiles
    cd /usr/local/lib/R/site-library/RAppArmor/
    sudo cp -Rf profiles/debian/* /etc/apparmor.d/
    
    #Load the profiles into the kernel
    sudo service apparmor restart
    
    #To disable enforcing the global R profile
    sudo aa-disable usr.bin.r
    
Enforce/Disable
---------------

To enforce the standard policy run

    sudo aa-enforce usr.bin.r
    
Do disable enforcing of the standard policy run:

    sudo aa-disable usr.bin.r

Please have a look at the [JSS paper](http://www.jstatsoft.org/v55/i07/) to understand how to use the software. 


Quick start guide
-----------------

Use the `eval.secure` function to dynamically evaluate a call with a certain AppArmor profile or hardware limits:

    list.files("/")
    eval.secure(list.files("/"), profile="r-user")
    
To set hardware limits:

	  A <- matrix(rnorm(1e7), 1e4);
    B <- eval.secure(matrix(rnorm(1e7), 1e4), RLIMIT_AS = 100*1024*1024);
    
Unit Testing
------------

The RAppArmor package ships with some unit tests that can be used to check if things are working properly:

    library(RAppArmor)
    unittests();        
    
See the `?unittests` help page for more info.

How to Cite
-----------


  
To cite RAppArmor in publications use:
  
	  Jeroen Ooms (2013). The RAppArmor Package: Enforcing Security Policies in R Using Dynamic Sandboxing on Linux. Journal of
	  Statistical Software, 55(7), 1-34. URL http://www.jstatsoft.org/v55/i07/.
  
A BibTeX entry for LaTeX users is
  
    @Article{,
      title = {The {RAppArmor} Package: Enforcing Security Policies in {R} Using Dynamic Sandboxing on Linux},
      author = {Jeroen Ooms},
      journal = {Journal of Statistical Software},
      year = {2013},
      volume = {55},
      number = {7},
      pages = {1--34},
      url = {http://www.jstatsoft.org/v55/i07/},
    }


Problems / Questions / Etc
--------------------------

For any problems, questions, suggestions on the installation or use of RAppArmor, please get in touch! 
We are very interested in hearing if anything is unclear or not working as expected. 

For general help, post a question on [Stack Overflow](http://stackoverflow.com/questions/tagged/rapparmor) and add the following tags: `rapparmor`, `r`, `apparmor`.

To report bugs, either [post an issue on github](https://github.com/jeroenooms/RAppArmor/issues), or send an email to [the maintainer](https://github.com/jeroenooms/RAppArmor/blob/master/DESCRIPTION).   
