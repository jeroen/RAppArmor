RAppArmor
=========

The R package RAppArmor or its debianized version r-cran-rapparmor, interfaces to a number of security related 
methods in the Linux kernel. 

Documentation
-------------

The most complete documentation can be found in the latest draft for the [JSS paper](https://github.com/jeroenooms/RAppArmor/raw/master/paper/document.pdf) for this package.

Support
-------

The package has been successfully build on:

* Ubuntu 12.04 and up (recommended)
* Debian 7 and up - [install notes](https://github.com/jeroenooms/RAppArmor/blob/master/Debian-Wheezy.txt)
* OpenSuse 12.1 and up - [install notes](https://github.com/jeroenooms/RAppArmor/blob/master/OpenSuse.txt)

For Ubuntu there is a convenient installation package available through launchpad. 

Installation on Ubuntu 12.04 and up
-----------------------------------

On Ubuntu the package is easily installed through launchpad (recommended):

    sudo add-apt-repository ppa:opencpu/rapparmor
    sudo apt-get update
    sudo apt-get install r-cran-rapparmor

Alternatively, too manually install on Ubuntu:

    #Download the package:
    wget https://github.com/jeroenooms/RAppArmor/zipball/master -O RAppArmor.zip
    unzip RAppArmor.zip
    
    #Install:
    sudo apt-get install r-base-dev libapparmor-dev apparmor
    sudo R CMD INSTALL jeroenooms-RAppArmor*
    
    #Install test profile:
    cd /usr/local/lib/R/site-library/RAppArmor/
    sudo cp -Rf profiles/debian/* /etc/apparmor.d/
    
    #Restart AppArmor
    sudo service apparmor restart
    
Installation on Debian / OpenSuse
-----------------------------------    

For Debian, see these [install notes](https://github.com/jeroenooms/RAppArmor/blob/master/Debian-Wheezy.txt)
For OpenSuse, see these [install notes](https://github.com/jeroenooms/RAppArmor/blob/master/OpenSuse.txt)


Enforce/Disable
---------------

To enforce the standard policy run

    sudo aa-enforce usr.bin.r
    
Do disable enforcing of the standard policy run:

    sudo aa-disable usr.bin.r

Please read the latest draft of the [JSS article](https://github.com/jeroenooms/RAppArmor/raw/master/paper/document.pdf)
to understand how to use the software. 


Using the software
------------------

Use the `eval.secure` function to dynamically evaluate a call under a certain AppArmor profile

    eval.secure(list.files("/"), profile="r-user")
    
You can also add RLIMIT values:

	A <- matrix(rnorm(1e7), 1e4);
    B <- eval.secure(matrix(rnorm(1e7), 1e4), RLIMIT_AS = 100*1024*1024);
    
If R is running with superuser privileges, you can also evaluate a call as a certain user:

    eval.secure(system('whoami', intern=TRUE), uid="jeroen")
        

    
