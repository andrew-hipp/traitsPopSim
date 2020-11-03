makeMat.sims <-
function(x, sites = attr(x, 'Nsites')[1], do = c('Means', 'Proportions'), probThresh = c(0.50), type = 'hsd') {
  if(type == 'hsd') {
    out <- matrix(NA, length(attr(x, 'Ntrees')), length(attr(x, 'Nleaves')),
                  dimnames = list(paste('Ntr', attr(x, 'Ntrees')),
                                  paste('Nlf', attr(x, 'Nleaves'))
                                  ) # close dimnames
                  ) # close out

    if(length(do) > 1) {
      out <- list(out)
      for(i in 2:length(do)) out <- c(out , out)
      names(out) <- do
    }
    for(trees in attr(x, 'Ntrees')) {
      message(paste('... doing Ntrees', trees))
      for(leaves in attr(x, 'Nleaves')) {
        #message(paste('...... doing Nleaves', leaves))
        vect <- sapply(x[[sites]][[trees]][[leaves]], function(a1) {
          # a1 %>% levels %>% paste(collapse = '') %>% strsplit("") %>% '[['(1) %>% unique %>% length
          a1 %>% unique %>% paste(collapse = '') %>% strsplit("") %>% '[['(1) %>% unique %>% length
          }) # close lapply
        if('Means' %in% do) out$Means[paste('Ntr', trees), paste('Nlf', leaves)] <- mean(vect)
        if('Proportions' %in% do) out$Proportions[paste('Ntr', trees), paste('Nlf', leaves)] <- sum(vect >= (sites * probThresh)) / length(vect)
      }
    }
    out <- lapply(out, as.data.frame)
  } # close if(type == 'hsd')
  else stop('non-hsd summaries not implemented yet')
  attr(out, 'Nsites') <- sites
  attr(out, 'Ntrees') <- attr(x, 'Ntrees')
  attr(out, 'Nleaves') <- attr(x, 'Nleaves')
  attr(out, 'probThresh') <- probThresh
  out
}
