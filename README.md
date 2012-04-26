rApparmor
=========

R interface to some AppArmor functions. 

To Install:

    #Download the package:
    wget https://github.com/jeroenooms/rApparmor/zipball/master -O rApparmor.zip
    unzip rApparmor.zip
    
    #Install:
    sudo apt-get install r-base libapparmor-dev
    sudo R CMD INSTALL jeroenooms-rApparmor*
    
    #Install test profile:
    cd jeroenooms-rApparmor*
    sudo cp test/myprofile /etc/apparmor.d

To test, open R console (/usr/bin/R) and run the lines from test/test.R

