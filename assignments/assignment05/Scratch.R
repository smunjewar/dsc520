# Efficient way to install and load the packages.  
# Reference - https://statsandr.com/blog/an-efficient-way-to-install-and-load-r-packages/

# Package names
packages <- c("ggplot2", "readxl", "dplyr", "tidyr", "ggfortify", "DT", "reshape2", "knitr", "lubridate", "pwr", "psy", "car", "doBy", "imputeMissings", "RcmdrMisc", "questionr", "vcd", "multcomp", "KappaGUI", "rcompanion", "FactoMineR", "factoextra", "corrplot", "ltm", "goeveg", "corrplot", "FSA", "MASS", "scales", "nlme", "psych", "ordinal", "lmtest", "ggpubr", "dslabs", "stringr", "assist", "ggstatsplot", "forcats", "styler", "remedy", "snakecaser", "addinslist", "esquisse", "here", "summarytools", "magrittr", "tidyverse", "funModeling", "pander", "cluster", "abind")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))


# - R-Reference book : R for Data Science.
# - https://r4ds.had.co.nz/transform.html

# Free dataset : https://blog.journeyofanalytics.com/50-free-datasets-for-data-science-projects/

# Something I encountered while completing this assignment was the group_by function will not work if the plyr is loaded. 
# If a function is not working due to a certain package loaded, you can use the detach function. 
# For example, detach(package:plyr). As many have stated previously, the order your packages are loaded is important.