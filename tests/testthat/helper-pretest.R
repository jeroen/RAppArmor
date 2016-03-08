skip_if_no_apparmor <- function(){
  if (!aa_is_enabled(verbose = FALSE))
    skip("AppArmor not enabled")
}

if(aa_is_enabled()){
  con <- aa_getcon(verbose=FALSE);
  profile <- con$con;
  switch(profile,
     "/usr/bin/R" = stop("Main process must be unconfined. Please run: sudo aa-disable usr.bin.r"),
     "unconfined" = cat("Pretest: OK\n"),
     stop("Main process must be unconfined (", profile, ")")
  );
}
