RAppArmor
=========

R interface to some AppArmor functions. Only works on Linux distributions that support Apparmor, E.g. Ubuntu, Suse, Arch, etc.

To Install:

    #Download the package:
    wget https://github.com/jeroenooms/rApparmor/zipball/master -O rApparmor.zip
    unzip rApparmor.zip
    
    #Install:
    sudo apt-get install r-base libapparmor-dev
    sudo R CMD INSTALL jeroenooms-RAppArmor*
    
    #Install test profile:
    cd jeroenooms-RAppArmor*
    sudo cp test/testprofile /etc/apparmor.d

To test, open R console (/usr/bin/R) and run the lines from test/test.R

