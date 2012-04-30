## Before you begin:
#sudo cp myprofile /etc/apparmor.d
#sudo service apparmor restart

#Load library
library(rApparmor);

#test unconstrained
read.table("/etc/passwd")

#Try to change to a profile
aa_change_profile("myprofile")

#test profile
read.table("/etc/passwd") #deny
read.table("/etc/group") #allow

#Change to a hat within the profile, and change back
mytoken <- as.integer(123);
aa_change_hat("myhat", mytoken);

#test hat
read.table("/etc/passwd") #deny
read.table("/etc/group") #deny

#revert back
aa_revert_hat(mytoken);

#test without hat
read.table("/etc/passwd") #deny
read.table("/etc/group") #allow
