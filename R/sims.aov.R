sims.aov <-
function(sl, writeDat = TRUE) {
  ## generate anovas
  aovList <- vector('list')
  for(sites in attr(sl, 'Nsites')) {
    aovList[[sites]] <- vector('list')
    for(trees in attr(sl, 'Ntrees')) {
      aovList[[sites]][[trees]] <- vector('list')
      for(leaves in attr(sl, 'Nleaves')) {
        message(paste('Doing', sites, 'sites of', trees, 'trees, each with', leaves, 'leaves;', length(sl[[sites]][[trees]][[leaves]]), 'replicates'))
        aovList[[sites]][[trees]][[leaves]] <- mclapply(sl[[sites]][[trees]][[leaves]], function(x) {
          aov(bladeL ~ site + tree, x)
          }, mc.cores = Ncores) # close mclapply
      }
    }
  }
  attr(aovList, 'Nsites') <- attr(sl, 'Nsites')
  attr(aovList, 'Ntrees') <- attr(sl, 'Ntrees')
  attr(aovList, 'Nleaves') <- attr(sl, 'Nleaves')
  if(writeDat) save(aovList, file = format(Sys.time(), 'aovList.%Y-%m-%d.Rdata'))
  aovList
  }
