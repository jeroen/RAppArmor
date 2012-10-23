context("pretest")
con <- aa_getcon(verbose=FALSE);
stopifnot(con$con == "unconfined");
cat("OK")