##### Introduction
#
# This document accompanies the JSS manuscript titled: "The RAppArmor Package: 
# Enforcing Security Policies in R Using Dynamic Sandboxing on Linux". Please 
# see the paper for installation instructions of the RAppArmor package. Note 
# that as is emphasized in the paper, a valid LINUX system is needed to install
# the package and run these examples.
#
# Furthermore: this code is here for completeness and compliance with JSS policy.
# Please refer to the paper for instructions how to run the code, and what the
# expected output is. Some pieces of code are supposed to throw an error.
#
# Also note that as described in the paper, applying security restrictions is
# often a irreversible action. Therefore, many of the code snippets below need 
# to be executed in a new 'clean' R session, that does not inherit restrictions
# which were applied by previously executed code blocks. It is not possible to 
# run this entire script at once.
 

##### Section 3.1: 
# Example of a plotting function
#
liveplot <- function (ticker) {
  url <- paste("http://ichart.finance.yahoo.com/table.csv?s=",
    ticker, "&a=07&b=19&c=2004&d=07&e=13&f=2020&g=d&ignore=.csv", sep = "")
  mydata <- read.csv(url)
  mydata$Date <- as.Date(mydata$Date)
  myplot <- ggplot2::qplot(Date, Close, data = mydata, 
    geom = c("line", "smooth"), main = ticker)
  print(myplot)
}

liveplot("GOOG")


##### Section 3.2
# Example of a hidden system call
#
foo <- get(paste("sy", "em", sep="st"))
bar <- paste("who", "i", sep="am")
foo(bar)


##### Section 3.5
# Switching user ID.
# Run as root!
# Replace '1000' with a valid UID.
#
library("RAppArmor")
system('whoami')
getuid()
getgid()
setgid(1000)
setuid(1000)
getgid()
getuid()
system('whoami')


##### Section 3.6
# Example of setting priority
#
library("RAppArmor")
getpriority()
setpriority(10)
getpriority()

# New session:
#
library("RAppArmor")
getpriority()
eval.secure(system('nice', intern=T), priority=10)
getpriority()


##### Section 3.7
# RLIMIT
#
library("RAppArmor")
rlimit_as()
A <- rnorm(1e7)
rm(A)
gc()
rlimit_as(10*1024*1024)
A <- rnorm(1e7)

## New session:
#
library("RAppArmor")
A <- eval.secure(rnorm(1e7), RLIMIT_AS = 10*1024*1024);
A <- rnorm(1e7)


##### Section 3.8
# Profiles
#
library("RAppArmor");
result <- read.table("/etc/passwd")
aa_change_profile("testprofile")
passwd <- read.table("/etc/passwd")

group <- read.table("/etc/group")
mytoken <- 13337;
aa_change_hat("testhat", mytoken)
passwd <- read.table("/etc/passwd")
group <- read.table("/etc/group")
aa_revert_hat(mytoken)
group <- read.table("/etc/group")

## New session:
#
out <- eval(read.table("/etc/passwd"))
out <- eval.secure(read.table("/etc/passwd"), profile="testprofile")


##### Section 5.2
# Profile r-base
#
library("RAppArmor")
aa_change_profile("r-base")
list.files("/")
list.files("~")
file.create("~/test")
list.files("/tmp")
install.packages("wordcloud")

library("ggplot2");
setwd(tempdir())
pdf("test.pdf")
qplot(speed, dist, data=cars)
dev.off()

list.files()
file.remove("test.pdf")


##### Section 5.3
# Profile: r-compile
#
library("RAppArmor")
eval.secure(install.packages("wordcloud", lib=tempdir()), profile="r-compile");


##### Appendix B1
# Acccess to system logs
#
readSyslog <- function(){
  readLines('/var/log/syslog');
}
eval.secure(readSyslog(), profile='r-user')


##### Appendix B2
# Access user files
#
findCreditCards <- function(){
  pattern <- "([0-9]{4}[- ]){3}[0-9]{4}"
  for (filename in list.files("~/Documents", full.names=TRUE, recursive=TRUE)){
    if(file.info(filename)$size > 1e6) next;
    doc <- readLines(filename)
    results <- gregexpr(pattern, doc)
    output <- unlist(regmatches(doc, results));
    if(length(output) > 0){
      cat(paste(filename, ":", output, collapse="\n"), "\n")
    }
  }
}
findCreditCards()


##### Appendix B3
# Limiting memory
#
memtest <- function(){
  A <- matrix(rnorm(1e7), 1e4);
}
A <- eval.secure(memtest(), RLIMIT_AS = 1000*1024*1024)
A <- eval.secure(memtest(), RLIMIT_AS = 100*1024*1024)


##### Appendix B4
# Limiting CPU time
#
cputest <- function(){
  A <- matrix(rnorm(1e7), 1e3);
  B <- svd(A);
}

Sys.time()
x <- eval.secure(cputest(), RLIMIT_CPU=5)
Sys.time()

Sys.time()
eval.secure(cputest(), timeout=5)
Sys.time()


##### Appendix B5
# Preventing Fork Bomb
#
forkbomb <- function(){
  repeat{
    parallel::mcparallel(forkbomb());
  }
}
eval.secure(forkbomb(), RLIMIT_NPROC = 20)



