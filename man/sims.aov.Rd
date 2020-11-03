\name{sims.aov}
\alias{sims.aov}
\title{
ANOVA on simulated data
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
sims.aov(sl, writeDat = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sl}{
%%     ~~Describe \code{sl} here~~
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
function (sl, writeDat = TRUE)
{
    aovList <- vector("list")
    for (sites in attr(sl, "Nsites")) {
        aovList[[sites]] <- vector("list")
        for (trees in attr(sl, "Ntrees")) {
            aovList[[sites]][[trees]] <- vector("list")
            for (leaves in attr(sl, "Nleaves")) {
                message(paste("Doing", sites, "sites of", trees,
                  "trees, each with", leaves, "leaves;", length(sl[[sites]][[trees]][[leaves]]),
                  "replicates"))
                aovList[[sites]][[trees]][[leaves]] <- mclapply(sl[[sites]][[trees]][[leaves]],
                  function(x) {
                    aov(bladeL ~ site + tree, x)
                  }, mc.cores = Ncores)
            }
        }
    }
    attr(aovList, "Nsites") <- attr(sl, "Nsites")
    attr(aovList, "Ntrees") <- attr(sl, "Ntrees")
    attr(aovList, "Nleaves") <- attr(sl, "Nleaves")
    if (writeDat)
        save(aovList, file = format(Sys.time(), "aovList.\%Y-\%m-\%d.Rdata"))
    aovList
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
