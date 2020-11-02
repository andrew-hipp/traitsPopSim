\name{makeMat.sims}
\alias{makeMat.sims}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
makeMat.sims(x, sites, do = c("Means", "Proportions"), probThresh = c(0.5), type = "hsd")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{sites}{
%%     ~~Describe \code{sites} here~~
}
  \item{do}{
%%     ~~Describe \code{do} here~~
}
  \item{probThresh}{
%%     ~~Describe \code{probThresh} here~~
}
  \item{type}{
%%     ~~Describe \code{type} here~~
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
function (x, sites, do = c("Means", "Proportions"), probThresh = c(0.5), 
    type = "hsd") 
{
    if (type == "hsd") {
        out <- matrix(NA, length(attr(x, "Ntrees")), length(attr(x, 
            "Nleaves")), dimnames = list(paste("Ntr", attr(x, 
            "Ntrees")), paste("Nlf", attr(x, "Nleaves"))))
        if (length(do) > 1) {
            out <- list(out)
            for (i in 2:length(do)) out <- c(out, out)
            names(out) <- do
        }
        for (trees in attr(x, "Ntrees")) {
            message(paste("... doing Ntrees", trees))
            for (leaves in attr(x, "Nleaves")) {
                vect <- sapply(x[[sites]][[trees]][[leaves]], 
                  function(a1) {
                    a1 \%>\% levels \%>\% paste(collapse = "") \%>\% 
                      strsplit("") \%>\% 1[[]] \%>\% unique \%>\% length
                  })
                if ("Means" \%in\% do) 
                  out$Means[paste("Ntr", trees), paste("Nlf", 
                    leaves)] <- mean(vect)
                if ("Proportions" \%in\% do) 
                  out$Proportions[paste("Ntr", trees), paste("Nlf", 
                    leaves)] <- sum(vect >= (sites * probThresh))/length(vect)
            }
        }
        out <- lapply(out, as.data.frame)
    }
    else stop("non-hsd summaries not implemented yet")
    attr(out, "Nsites") <- sites
    attr(out, "Ntrees") <- attr(x, "Ntrees")
    attr(out, "Nleaves") <- attr(x, "Nleaves")
    attr(out, "probThresh") <- probThresh
    out
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
