\name{genSims}
\alias{genSims}
\title{
Generate simulated trait data structured by population
}
\description{
This function creates the simulated datasets for
}
\usage{
genSims(Nsites, Ntrees, Nleaves, Nreps, siteMeans, treeMeans, all.dat, chars, writeDat = TRUE)
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
Data frame: characters measured (in the example, on leaves), with characters as columns; should include a column called "tree" for individuals
}
  \item{chars}{
Vector: characters to include in simulation
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
otm <- as.data.frame(t(sapply(split(oaks$traits[c('lat', 'long', 'tree', 'site', oaks$charVec)], oaks$traits$tree), function(x) apply(x, 2, mean))))

simsList <- genSims(Nsites = 5,
                    Ntrees = 3:8,
                    Nleaves = 3:8,
                    Nreps = 20,
                    all.dat = oaks$traits,

                    )

simsAOV <- sims.aov(simsList)
simsHSD <- sims.hsd(simsAOV)

plot.hsd(simsHSD, probThresh = 0.5)

  }
}
