pkgs <- c("tidyverse",
          "readxl",
          "rvest",
          "htmltab",
          "stringr")

installed_pkgs <- pkgs %in% installed.packages() # check which packages are not yet installed
if (length(pkgs[!installed_pkgs]) > 0) install.packages(pkgs[!installed_pkgs],dep=TRUE) # if some packages are not yet installed, go ahead and install them...
lapply(pkgs, library, character.only = TRUE) # ...then load all the packages and their dependencies

