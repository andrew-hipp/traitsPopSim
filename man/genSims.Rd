\name{genSims}
\alias{genSims}
\title{
Generate simulated trait data structured by population
}
\description{
This function simulates trait data in a structured hierarchical
    sampling design, where observations ("leaves") are nested within individuals
    ("trees"), and individuals within "sites" or populations.
}
\usage{
genSims(Nsites, Ntrees, Nleaves, Nreps, siteMeans, treeMeans, all.dat, chars, Ncores = 1, writeDat = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Nsites}{
Number of sites to simulate: a single integer
}
  \item{Ntrees}{
Number of trees to simulate per site: a range of integers (e.g., 3:10) or selected numbers (e.g., c(3,5,10))
}
  \item{Nleaves}{
Number of leaves to simulate per tree: a range of integers (e.g., 3:10) or selected numbers (e.g., c(3,5,10))
}
  \item{Nreps}{
Number of simulated datasets to generate
}
  \item{siteMeans}{
Data frame: character means by site, with characters as columns
}
  \item{treeMeans}{
Data frame: character means by individual, with characters as columns; should include a column called "site" with the site each individual comes from
}
  \item{all.dat}{
Data frame: characters measured (in the example, on leaves), with characters as columns; should include a column called "tree" for individuals amd one called "site"
}
  \item{chars}{
Vector: characters to include in simulation; must match a subset of the columns in
    siteMeans, treeMeans, and all.dat
}
\item{Ncores}{
Integer: number of processing cores to use (based on Parallel package)
}
  \item{writeDat}{
Boolean: whether to write the list containing simulations to disk
}
}
\details{
This can be a time-consuming and memory-consuming simulation; start with a small number of alternatives and reps and work from there
}
\value{
A nested list, with observations nested within individuals nested within sites.
}
\references{
To be added after publication
}
\author{
Andrew L Hipp (ahipp@mortonarb.org)
}

\examples{
data(oaks)
otm <- as.data.frame(t(sapply(split(oaks$traits[oaks$charVec], oaks$traits$tree), function(x) apply(x, 2, mean))))
otm$site <- oaks$traits$site[match(row.names(otm), oaks$traits$tree)]
osm <- as.data.frame(t(sapply(split(otm[, oaks$charVec], otm$site), function(x) apply(x, 2, mean))))

simsList <- genSims(Nsites = 10, # all sims will have 5 sites; ordinarily, 20 or more
                    Ntrees = c(5,10,15), # 5, 10, or 15 trees per site
                    Nleaves = 3:8, # 3-8 leaves per tree
                    Nreps = 20, # 20 reps; ordinarily, 100 or more
                    all.dat = oaks$traits, # data frame of all data
                    siteMeans = osm, # data averaged by sites, from the tree average
                    treeMeans = otm, # data averaged by tree
                    chars = oaks$charVec, # characters to analyze
                    writeDat = FALSE # whether to write out the analysis list
                    )

simsAOV <- sims.aov(simsList)
simsHSD <- sims.hsd(simsAOV)

plot.hsd(simsHSD, probThresh = 0.3)
}
