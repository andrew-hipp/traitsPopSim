\name{plot.hsd}
\alias{plot.hsd}
\title{
Plots Tukey's HSD results
}
\description{
Using sims.hsd output, plots a heatmap of the number of Tukey's HSD categories
    found under each of the simulations, as well as the probability of finding
    the threshold number of different
}
\usage{
plot.hsd(x, whichdo = c("Means", "Proportions"), useValNames = FALSE, printVals = TRUE, ...)
}
\arguments{
  \item{x}{
output from sims.hsd
}
  \item{whichdo}{
Currently only "Means" and "Proportions" is implemented. Currently defaults to
    plotting both. "Mean" returns a plot panel that shows the mean number of
    groups identified using Tukey's HSD; "Proportions" yields a plot panel that
    shows the probability of recognizing at least the threshold percent of groups.
}
  \item{useValNames}{
Currently, leave at default value
}
  \item{printVals}{
If TRUE, prints the means and proportions on the plot along with the heatmap;
    if FALSE, heatmap only, no values printed
}
  \item{\dots}{
Options to pass along to makeMat.sims (which is not exported). Use \code{probThresh}
    to set the threshold percentage of populations you are interested in identifying
    for power analyses. If for example you are simulating 20 populations and want
    to quantify the power to distinguish at least 10 groups using Tukey's HSD,
    set \code{probThresh = 0.5} [which is the default].
}
}
\details{
See example under genSims
}
\value{
Called for its side-effect (plotting)
}
\references{
Add citation after publication
}
\author{
Andrew L Hipp (ahipp@mortonarb.org)
}

\seealso{
\code{\link{genSims}}
\code{\link{sims.hsd}}
}
