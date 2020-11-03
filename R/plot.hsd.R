plot.hsd <-
function(x, whichdo = c('Means', 'Proportions'), useValNames = FALSE, printVals = TRUE, ...) {
  if(class(x[[length(x)]]) == 'list') x <- makeMat.sims(x, sites = which(sapply(x, function(x) !is.null(x))), do = whichdo, ...)
  p <- vector('list', 2)
  for(i in 1:length(whichdo)) {
    x.means <- x[[whichdo[i]]]
    x.means$Ntrees <- attr(x, 'Ntrees')
    names(x.means)[grep('Ntrees', names(x.means))] <- "Number_of_trees_per_site"
    x.means <- melt(x.means, id.vars = 'Number_of_trees_per_site',
                             variable_name= 'Number_of_leaves_per_tree')
    if(useValNames) {
      names(x.means)[which(names(x.means) == 'value')] <-
      switch(whichdo, mean = 'Mean_groups_identified_using_Tukey_HSD',
                      prob = paste('Probability_of_distinguishing', attr(x, 'probThresh'), 'proportion_of_populations', sep = '_')
                      )
                    }
    x.means$Number_of_leaves_per_tree <- gsub('Nlf ', '', x.means$Number_of_leaves_per_tree) %>%
      as.integer
    p[[i]] <- ggplot(x.means, aes(x = Number_of_leaves_per_tree, y = Number_of_trees_per_site,
                                   #fill = Mean_groups_identified_using_Tukey_HSD))
                                   fill = value),
                      show.legend = FALSE)
    p[[i]] <- p[[i]] + geom_tile()
    if(printVals) {
      p[[i]] <- p[[i]] + geom_text(aes(label = value), color = 'white', size = 2)
      p[[i]] <- p[[i]] + theme(legend.position = 'none')
    }
    p[[i]] <- p[[i]] +
      ggtitle(label = ifelse(whichdo[i] == 'Proportions',
                paste('Probability of recognizing', attr(x, 'probThresh') * 100, 'percent of populations'),
                paste('Mean groups recognized out of', attr(x, 'Nsites'), 'populations')
                ) # close ifelse
              ) # close ggtitle
    p[[i]] <- p[[i]] + theme(axis.title.x = element_blank(),
                             axis.title.y = element_blank())
    p[[i]] <- p[[i]] + scale_x_continuous(breaks = attr(x, 'Nleaves'))
    p[[i]] <- p[[i]] + scale_y_continuous(breaks = attr(x, 'Ntrees'))
  }
  grid.arrange(grobs = p, nrow = 1,
               left = "Number of trees per site",
               bottom = "Number of leaves per tree")
}
