\name{sims.aov}
\alias{sims.aov}
\title{
ANOVA on simulated data
}
\description{
Conducts one-way ANOVA on the output of \code{genSims}
}
\usage{
sims.aov(sl, Ncores = 1, writeDat = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sl}{
Output from genSims
}
\item{Ncores}{
Number of cores to use in generating ANOVAS; calls mclapply in parallel
}
  \item{writeDat}{
Boolean: whether to write output to disk
}
}
\value{
A list of \code{aov} results with the same structure as the genSims list;
    attributes are Nsites, Ntrees, Nleaves
}
\references{
Desmond SC, Garner M, Flannery S, Whittemore AT, Hipp AL. 2020. Leaf shape and size variation in bur oaks: An empirical study and simulation of sampling strategies. bioRxiv: 2020.05.11.088039.
}
\author{
Andrew L Hipp (ahipp@mortonarb.org)
}
\seealso{
\code{\link{genSims}}, \code{\link{sims.hsd}}, \code{\link{plot.hsd}}
}
