## Before you begin: make sure 'testprofile' is loaded'
#sudo cp inst/profiles/debian/testprofile /etc/apparmor.d
#sudo service apparmor restart

#Load library
library(RAppArmor);

#test unconstrained
result <- read.table("/etc/passwd")

#Try to change to a profile
aa_change_profile("testprofile")

#test profile
result <- try(read.table("/etc/passwd"), silent=TRUE) #deny
if(class(result) != "try-error") stop("Profile should have denied access to /etc/passwd but didn't.")
result <- read.table("/etc/group") #allow

#Change to a hat within the profile, and change back
mytoken <- 13337;
aa_change_hat("testhat", mytoken);

#test hat
result <- try(read.table("/etc/passwd"), silent=TRUE) #deny
if(class(result) != "try-error") stop("Hat should have denied access to /etc/passwd but didn't.")
result <- try(read.table("/etc/group"), silent=TRUE) #deny
if(class(result) != "try-error") stop("Hat should have denied access to /etc/group but didn't.")

#revert back
aa_revert_hat(mytoken);

#test without hat
result <- try(read.table("/etc/passwd"), silent=TRUE) #deny
if(class(result) != "try-error") stop("Profile should have denied access to /etc/passwd but didn't.")
result <- read.table("/etc/group") #allow
