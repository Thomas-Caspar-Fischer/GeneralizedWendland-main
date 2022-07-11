# GeneralizedWendland

Dedicated Repository for GeneralizedWendland R package

## Currently working on
- Package documentation


## Status
R CMD check --as-cran --no-multiarch

- 0 errors
- 1 warnings ('qpdf' requirement for checks on size reduction)
- 1 note (Dropping empty sections)


## Changelog

### 18.03.2022


### 17.03.2022


### 16.03.2022
- Reverted to previous system of handling user input for control.cov
- Added unit tests via testthat
- Initialized vignette

### 15.03.2022
- Initialized Rd files
- Deprecated insertGlobalDefaults function
- Updated/improved DESCRIPTION file
- Updated README.md 

## Issues
- QAG/QAGS integration does not work correctly
- R CMD check --as-cran fails unless --no-multiarch option is used. Will 
  change to a more sophisticated testing system next week

## Ideas/Plans
- Option to compute purely in R?
- Rewrite code for retaining data type of input object h
