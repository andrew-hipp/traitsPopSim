\name{genSims}
\alias{genSims}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
genSims(Nsites, Ntrees, Nleaves, Nreps, siteMeans, treeMeans, all.dat, chars, writeDat = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Nsites}{
%%     ~~Describe \code{Nsites} here~~
}
  \item{Ntrees}{
%%     ~~Describe \code{Ntrees} here~~
}
  \item{Nleaves}{
%%     ~~Describe \code{Nleaves} here~~
}
  \item{Nreps}{
%%     ~~Describe \code{Nreps} here~~
}
  \item{siteMeans}{
%%     ~~Describe \code{siteMeans} here~~
}
  \item{treeMeans}{
%%     ~~Describe \code{treeMeans} here~~
}
  \item{all.dat}{
%%     ~~Describe \code{all.dat} here~~
}
  \item{chars}{
%%     ~~Describe \code{chars} here~~
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
function (Nsites, Ntrees, Nleaves, Nreps, siteMeans, treeMeans, 
    all.dat, chars, writeDat = TRUE) 
{
    Csites <- cov(siteMeans[, chars])
    Ctrees <- lapply(split(otm[, chars], otm$site), cov) \%>\% 
        Reduce("+", .)/length(unique(otm$site))
    Cleaves <- lapply(split(all.dat[, chars], all.dat$tree), 
        cov) \%>\% Reduce("+", .)/length(unique(all.dat$tree))
    simulationsList <- vector("list")
    for (sites in Nsites) {
        simulationsList[[sites]] <- vector("list")
        for (trees in Ntrees) {
            simulationsList[[sites]][[trees]] <- vector("list")
            for (leaves in Nleaves) {
                message(paste("Doing", sites, "sites of", trees, 
                  "trees, each with", leaves, "leaves;", Nreps, 
                  "replicates"))
                simulationsList[[sites]][[trees]][[leaves]] <- mclapply(seq(Nreps), 
                  function(...) {
                    if (exists("leavesSim.frame")) 
                      rm(leavesSim.frame)
                    siteMeansSim <- rmvnorm(sites, mean = apply(siteMeans[, 
                      chars], 2, mean), sigma = Csites)
                    treeMeansSim <- lapply(split(siteMeansSim, 
                      row(siteMeansSim)), function(x) rmvnorm(n = trees, 
                      mean = x, sigma = Ctrees))
                    leavesSim <- lapply(treeMeansSim, function(x) {
                      lapply(split(x, row(x)), function(y) {
                        rmvnorm(n = leaves, mean = y, sigma = Cleaves) \%>\% 
                          as.data.frame
                      })
                    })
                    for (i in 1:length(leavesSim)) {
                      for (j in 1:length(leavesSim[[i]])) {
                        leavesSim[[i]][[j]]$site <- i
                        leavesSim[[i]][[j]]$tree <- j
                        if (!exists("leavesSim.frame")) 
                          leavesSim.frame <- leavesSim[[i]][[j]]
                        else leavesSim.frame <- rbind(leavesSim.frame, 
                          leavesSim[[i]][[j]]) \%>\% as.data.frame
                      }
                    }
                    names(leavesSim.frame) <- c(chars, "site", 
                      "tree")
                    leavesSim.frame$site <- factor(leavesSim.frame$site)
                    leavesSim.frame$tree <- factor(leavesSim.frame$tree)
                    leavesSim.frame
                  }, mc.cores = Ncores)
            }
        }
    }
    attr(simulationsList, "Nsites") <- Nsites
    attr(simulationsList, "Ntrees") <- Ntrees
    attr(simulationsList, "Nleaves") <- Nleaves
    if (writeDat) 
        save(simulationsList, file = format(Sys.time(), "simsList.\%Y-\%m-\%d.Rdata"))
    return(simulationsList)
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
