\name{plot.hsd}
\alias{plot.hsd}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
plot.hsd(x, whichdo = c("Means", "Proportions"), useValNames = FALSE, printVals = TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{whichdo}{
%%     ~~Describe \code{whichdo} here~~
}
  \item{useValNames}{
%%     ~~Describe \code{useValNames} here~~
}
  \item{printVals}{
%%     ~~Describe \code{printVals} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
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
function (x, whichdo = c("Means", "Proportions"), useValNames = FALSE, 
    printVals = TRUE, ...) 
{
    if (class(x[[length(x)]]) == "list") 
        x <- makeMat.sims(x, whichdo, ...)
    p <- vector("list", 2)
    for (i in 1:length(whichdo)) {
        x.means <- x[[whichdo[i]]]
        x.means$Ntrees <- attr(x, "Ntrees")
        names(x.means)[grep("Ntrees", names(x.means))] <- "Number_of_trees_per_site"
        x.means <- melt(x.means, id.vars = "Number_of_trees_per_site", 
            variable_name = "Number_of_leaves_per_tree")
        if (useValNames) {
            names(x.means)[which(names(x.means) == "value")] <- switch(whichdo, 
                mean = "Mean_groups_identified_using_Tukey_HSD", 
                prob = paste("Probability_of_distinguishing", 
                  attr(x, "probThresh"), "proportion_of_populations", 
                  sep = "_"))
        }
        x.means$Number_of_leaves_per_tree <- gsub("Nlf ", "", 
            x.means$Number_of_leaves_per_tree) \%>\% as.integer
        p[[i]] <- ggplot(x.means, aes(x = Number_of_leaves_per_tree, 
            y = Number_of_trees_per_site, fill = value), show.legend = FALSE)
        p[[i]] <- p[[i]] + geom_tile()
        if (printVals) {
            p[[i]] <- p[[i]] + geom_text(aes(label = value), 
                color = "white", size = 2)
            p[[i]] <- p[[i]] + theme(legend.position = "none")
        }
        p[[i]] <- p[[i]] + ggtitle(label = ifelse(whichdo[i] == 
            "Proportions", paste("Probability of recognizing", 
            attr(x, "probThresh") * 100, "percent of populations"), 
            paste("Mean groups recognized out of", attr(x, "Nsites"), 
                "populations")))
        p[[i]] <- p[[i]] + theme(axis.title.x = element_blank(), 
            axis.title.y = element_blank())
        p[[i]] <- p[[i]] + scale_x_continuous(breaks = attr(x, 
            "Nleaves"))
        p[[i]] <- p[[i]] + scale_y_continuous(breaks = attr(x, 
            "Ntrees"))
    }
    grid.arrange(grobs = p, nrow = 1, left = "Number of trees per site", 
        bottom = "Number of leaves per tree")
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
