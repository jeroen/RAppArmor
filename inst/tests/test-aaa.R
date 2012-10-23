context("pretest")
con <- aa_getcon(verbose=FALSE);
profile <- con$con;

switch(profile,
	"/usr/bin/R" = stop("Main process must be unconfined. Please run: sudo aa-disable usr.bin.r"),
	"unconfined" = cat("OK"),
	stop("Main process must be unconfined (", profile, ")")
);
