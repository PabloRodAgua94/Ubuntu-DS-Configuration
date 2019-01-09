install_opts <- "--byte-compile"
reinstall <- FALSE

# Installation functions
installed <- data.frame(installed.packages())$Package
# Get the bioconductor from source
source("http://bioconductor.org/biocLite.R")

is.installed <- function(package.name) package.name %in% installed

pastemsg <- function(...) message(paste(...))
installer <- function(install.fn, ...) {
  do.install <- function(package.name, check.installed=!reinstall) {
    if(check.installed && is.installed(package.name)) {
      pastemsg("Package", package.name, "is installed.")
    } else {
      pastemsg("Installing", package.name)
      install.fn(c(package.name), ...)
    }
  }
}

# Special installer for CRAN
install_cran <- installer(install.packages, repos="http://cran.fhcrc.org",
                          clean=TRUE, dependencies=TRUE,
                          INSTALL_opts=install_opts)

# Special installer for bioconductor
install_bioconductor <- installer(biocLite, ask=FALSE, INSTALL_opts=install_opts)

## Bioconductor Packages
bioconductor_ <- paste(readLines('bioconductor_packages.txt'), sep = "\n")
if(length(bioconductor_)){
  library(BiocInstaller)
  bioconductor_packages <- bioconductor_[!(bioconductor_ %in% installed.packages()[, "Package"])]
  for(p in bioconductor_packages) {
    tryCatch(install_bioconductor(p), error=warning)
  }
}

## CRAN Packages
cran_ <- paste(readLines('cran_packages.txt'), sep = "\n")
if(length(cran_)){
  print("Installing Packages from Cran")
  cran_packages <- cran_[!(cran_ %in% installed.packages()[, "Package"])]
  for(p in cran_packages) {
    tryCatch(install_cran(p), error=warning)
  }
}


## GitHub Package
github_ <- paste(readLines('github_packages.txt'), sep="\n")
if(length(github_)){
  print("Installing Packages from GitHub")
  github_packages <- github_[!(github_ %in% installed.packages()[, "Package"])]
  for(p in github_packages) {
    pastemsg("Installing", p, "from GitHub")
    p <- list(p)
    p$args <- install_opts
    tryCatch(do.call('install_github', p), error=warning)
  }
}