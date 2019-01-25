install_opts <- "--byte-compile"
reinstall <- FALSE

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Installation functions
installed <- data.frame(installed.packages())$Package

# Get the bioconductor from source
source("http://bioconductor.org/biocLite.R")
ow
# This function verifies the installation of the package.
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
install_cran <- installer(install.packages, repos="http://cran.fhcrc.org", clean=TRUE, dependencies=TRUE, INSTALL_opts=install_opts)

# Special installer for bioconductor
install_bioconductor <- installer(biocLite, ask=FALSE, INSTALL_opts=install_opts)

## Bioconductor Packages Installation 

bioconductor_ <- paste(readLines('bioconductor_pckgs.txt'), sep = "\n")

if(length(bioconductor_)) {
	library(BiocInstaller)
	bioconductor_pckgs <- bioconductor_[!(bioconductor_ %in% installed.packages()[, "Package"])]
	for(pckg in bioconductor_pckgs) {
		tryCatch(install_bioconductor(pckg), error=warning)
	}
}


## CRAN Packages
cran_ <- paste(readLines('cran_pckgs.txt'), sep = "\n")

if(length(cran_)) {
	print("Installing Packages from Cran")
	cran_pckgs <- cran_[!(cran_ %in% installed.packages()[, "Package"])]
	for(pckg in cran_pckgs) {
		tryCatch(install_cran(pckg), error=warning)
	}
}


## GitHub Packages 
## NOTE: This method only works on versions < 3.5.2
if ("install_github" %in% rownames(installed.packages()) == FALSE ) {
	print("Installing: 'install_github'")
	install.packages('install_github')
} else {
	print("'install_github' already installed...")
}

github_ <- paste(readLines('github_pckgs.txt'), sep="\n")
if (length(github_)) {
	print("Installing Packages from GitHub")
	github_pckgs <- github_[!(github_ %in% installed.packages()[, "Package"])]
	for(pckg in github_pckgs) {
		pastemsg("Installing", pckg, "from GitHub")
		pckg <- list(pckg)
		pckg$args <- install_opts
		tryCatch(do.call('install_github', pckg), error=warning)
	}
}