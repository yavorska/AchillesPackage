# AchillesPackage

This package can be used to analyse shRNA data in R. In particular, the Achilles datasets provided by the Broad Institute (which are included within the package). 

To load the package in R : 

library(devtools)

install_github("yavorska/AchillesPackage")

Note: due to the file size restrictions, one must manually include the Achilles2.4_data file in the package. 
- download the file at https://www.dropbox.com/s/rajtckpk9sx8174/Achilles2.4_data.RData?dl=0
- locate where the YavAch folder is located on your machine and open the "data" folder
- paste the Achilles2.4_data.Rd file into the folder and it should now be included as part of your package

library(YavAch)

The package should now be installed! See the vignette for a general description of what each function does.
