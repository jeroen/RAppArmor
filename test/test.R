## Before you begin:
#sudo cp myprofile /etc/apparmor.d
#sudo service apparmor restart

#Load library
library(rApparmor);

#Try to change to a profile
aa_change_profile("myprofile")

#Change to a hat within the profile, and change back
mytoken <- as.integer(123);
aa_change_hat("myhat", mytoken);
aa_revert_hat(mytoken);