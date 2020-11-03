\name{sims.hsd}
\alias{sims.hsd}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Tukey's HSD on simulations ANOVA
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
sims.hsd(sa, Ncores = 1, writeDat = TRUE)
}
\arguments{
  \item{sa}{
%%     ~~Describe \code{sa} here~~
}
  \item{Ncores}{
number of processing cores to use
}
  \item{writeDat}{
%%     ~~Describe \code{writeDat} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (sa, writeDat = TRUE)
{
    hsdList <- vector("list")
    for (sites in attr(sa, "Nsites")) {
        hsdList[[sites]] <- vector("list")
        for (trees in attr(sa, "Ntrees")) {
            hsdList[[sites]][[trees]] <- vector("list")
            for (leaves in attr(sa, "Nleaves")) {
                message(paste("Doing", sites, "sites of", trees,
                  "trees, each with", leaves, "leaves;", length(sa[[sites]][[trees]][[leaves]]),
                  "replicates"))
                hsdList[[sites]][[trees]][[leaves]] <- mclapply(sa[[sites]][[trees]][[leaves]],
                  function(x) {
                    HSD.test(x, "site")$groups$groups
                  }, mc.cores = Ncores)
            }
        }
    }
    attr(hsdList, "Nsites") <- attr(sa, "Nsites")
    attr(hsdList, "Ntrees") <- attr(sa, "Ntrees")
    attr(hsdList, "Nleaves") <- attr(sa, "Nleaves")
    if (writeDat)
        save(hsdList, file = format(Sys.time(), "hsdList.\%Y-\%m-\%d.Rdata"))
    hsdList
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
