# RAppArmor

##### *A Modern and Flexible Web Client for R*

[![Build Status](https://travis-ci.org/jeroen/RAppArmor.svg?branch=master)](https://travis-ci.org/jeroen/RAppArmor)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/RAppArmor)](http://cran.r-project.org/package=RAppArmor)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/RAppArmor)](http://cran.r-project.org/web/packages/RAppArmor/index.html)
[![Research software impact](http://depsy.org/api/package/cran/RAppArmor/badge.svg)](http://depsy.org/package/r/RAppArmor)
[![Github Stars](https://img.shields.io/github/stars/jeroen/RAppArmor.svg?style=social&label=Github)](https://github.com/jeroen/RAppArmor)

The R package RAppArmor interfaces to a number of security related methods in the Linux kernel. It supports the following functionality:

 * loading and changing AppArmor profiles and hats to enforce advanced security policies
 * setting RLIMIT values to restrict usage of memory, cpu, disk, etc
 * setting the process priority
 * switching uid/gid of the current process
 * setting the affinity mask of the current process
 * calling an R command with a 'timeout' to kill if it does not return with in n seconds
 * doing all of the above dynamically for a single R call using the `eval.secure` function  
 
This can be useful for example if to host a public service for users to run R code, or if you are paranoid about running contributed code on your machine. 

## Documentation

About the R package:

 * JSS paper: [Enforcing Security Policies in R Using Dynamic Sandboxing on Linux](http://www.jstatsoft.org/v55/i07/)
 * [Video Tutorials](http://www.youtube.com/playlist?list=PL3ZKTMqqbMktzcWjXuQCWOYc-fMROs3cf&feature=view_all) 3 short (10min) tutorials demonstrating core functionality.
 * [PDF manual](http://cran.r-project.org/web/packages/RAppArmor/RAppArmor.pdf) - Auto generated PDF documentation.

## Hello World

Use the [`eval.secure`](http://www.inside-r.org/packages/cran/RAppArmor/docs/eval.secure) function to dynamically evaluate a call with a certain AppArmor profile or hardware limits:

```r
list.files("/")
eval.secure(list.files("/"), profile="r-user")
```

To set hardware limits, use the `RLIMIT_XXX` arguments:

```r
A <- matrix(rnorm(1e7), 1e4);
B <- eval.secure(matrix(rnorm(1e7), 1e4), RLIMIT_AS = 100*1024*1024);
```

## Installation

The AppArmor linux module is available on the following distributions:

* Ubuntu 12.04 and up
* Debian 7 and up - [install notes](https://github.com/jeroen/RAppArmor/blob/master/Debian.txt)
* OpenSuse 12.1 and up - [install notes](https://github.com/jeroen/RAppArmor/blob/master/OpenSuse.txt)

Installing the R package requires [libapparmor-dev](http://packages.ubuntu.com/xenial/libapparmor-dev). The [apparmor-utils](http://packages.ubuntu.com/xenial/apparmor-utils) package is also recommended.

```sh
sudo apt-get install -y libapparmor-dev apparmor-utils
```

One this is installed we can install the R package:

```r
install.packages("RAppArmor")
```

The R package comes with some AppArmor profiles that you need to install manually:

```sh
#Install the profiles
cd /usr/local/lib/R/site-library/RAppArmor/
sudo cp -Rf profiles/debian/* /etc/apparmor.d/

#Load the profiles into the kernel
sudo service apparmor restart

#To disable enforcing the global R profile
sudo aa-disable usr.bin.r
```

To start enforcing the standard R policy:

```sh
sudo aa-enforce usr.bin.r
```
    
To stop enforcing of the standard policy:

```sh
sudo aa-disable usr.bin.r
```

Please have a look at the [JSS paper](http://www.jstatsoft.org/v55/i07/) to understand how to use the software. 

## Citing

To cite RAppArmor in publications use:
  
    Jeroen Ooms (2013). The RAppArmor Package: Enforcing Security Policies in R Using Dynamic Sandboxing
    on Linux. Journal of Statistical Software, 55(7), 1-34. URL http://www.jstatsoft.org/v55/i07/.
  
A BibTeX entry for LaTeX users is
  
    @Article{RAppArmor,
      title = {The {RAppArmor} Package: Enforcing Security Policies in {R} Using Dynamic Sandboxing on Linux},
      author = {Jeroen Ooms},
      journal = {Journal of Statistical Software},
      year = {2013},
      volume = {55},
      number = {7},
      pages = {1--34},
      url = {http://www.jstatsoft.org/v55/i07/},
    }

