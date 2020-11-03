\name{sims.hsd}
\alias{sims.hsd}
\title{
Tukey's HSD on simulations ANOVA
}
\description{
Conducts Tukey's honestly significant difference test on the simulation
    ANOVA output (from \code{sims.aov}) as a means of assessing how many
    different populations can be discriminated from the data simulated, with
    the reasoning that if there are 20 populations, the best reasonable outcome
    would be 20 groups.
}
\usage{
sims.hsd(sa, Ncores = 1, writeDat = TRUE)
}
\arguments{
  \item{sa}{
Output from \code{sims.hsd}
}
  \item{Ncores}{
Number of processing cores to use
}
  \item{writeDat}{
Boolean: if TRUE, write output to drive
}
}
\value{
A list of TukeyHSD results with the same nested structure as the \code{sims.aov}
    object passed into it.
}
\references{
Desmond SC, Garner M, Flannery S, Whittemore AT, Hipp AL. 2020. Leaf shape and size variation in bur oaks: An empirical study and simulation of sampling strategies. bioRxiv: 2020.05.11.088039.
}
\author{
Andrew L Hipp (ahipp@mortonarb.org)
}
