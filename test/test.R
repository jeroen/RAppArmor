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
result <- try(read.table("/etc/passwd")) #deny
if(class(result) != "try-error") stop(result)
read.table("/etc/group") #allow

#Change to a hat within the profile, and change back
mytoken <- as.integer(123);
aa_change_hat("myhat", mytoken);

#test hat
result <- try(read.table("/etc/passwd")) #deny
if(class(result) != "try-error") stop(result)
result <- try(read.table("/etc/group")) #deny
if(class(result) != "try-error") stop(result)

#revert back
aa_revert_hat(mytoken);

#test without hat
result <- try(read.table("/etc/passwd")) #deny
if(class(result) != "try-error") stop(result)
read.table("/etc/group") #allow
