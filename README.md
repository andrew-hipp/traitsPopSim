# traitsPopSim
_v0.9-1; 2020-11-03_  
[![DOI](https://zenodo.org/badge/309502947.svg)](https://zenodo.org/badge/latestdoi/309502947)  

R package for simulating traits collected in populations, with autocorrelation by individual and by population.

Before installing, install dependencies:

```r
install.packages('agricolae')
install.packages('egg')
install.packages('magrittr')
install.packages('mvtnorm')
install.packages('reshape')
```

Then, install from GitHub using `devtools`. If you are a Windows user, you will also
need `Rtools` (if you are using R > v4.0, follow the directions at https://cran.r-project.org/bin/windows/Rtools/, and be patient).

```r
install.packages('devtools')
library('devtools')
install_github('andrew-hipp/traitsPopSim', ref = 'main')
```

For a worked example, see https://github.com/andrew-hipp/oak-morph-2020,
released under [![DOI](https://zenodo.org/badge/140023087.svg)](https://zenodo.org/badge/latestdoi/140023087).

Note that you may get a "Lazy load database corrupt" error if you run the package
right after installation. If so, don't worry! Close R, open again, bring the package
back in using `library(traitsPopSim)` and it should work fine. I've installed
the package successfully from GitHub under Windows 10 (running R 4.0.2,
'Taking Off Again'; and R 3.6.2, 'Dark and Stormy Night') and Ubuntu 16.04 (running R 4.0.3, 'Bunny-Wunnies Freak Out').
