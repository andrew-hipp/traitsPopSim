sims.hsd <-
function(sa, Ncores = 1, writeDat = TRUE) {
  ## run HSD tests for all anovas
  ## return only number of unique groups at a given alpha
    hsdList <- vector('list')
    for(sites in attr(sa, 'Nsites')) {
      hsdList[[sites]] <- vector('list')
      for(trees in attr(sa, 'Ntrees')) {
        hsdList[[sites]][[trees]] <- vector('list')
        for(leaves in attr(sa, 'Nleaves')) {
          message(paste('Doing', sites, 'sites of', trees, 'trees, each with', leaves, 'leaves;', length(sa[[sites]][[trees]][[leaves]]), 'replicates'))
          hsdList[[sites]][[trees]][[leaves]] <- mclapply(sa[[sites]][[trees]][[leaves]], function(x) {
            HSD.test(x, 'site')$groups$groups
            }, mc.cores = Ncores) # close mclapply
          }
        }
      }
    attr(hsdList, 'Nsites') <- attr(sa, 'Nsites')
    attr(hsdList, 'Ntrees') <- attr(sa, 'Ntrees')
    attr(hsdList, 'Nleaves') <- attr(sa, 'Nleaves')
    if(writeDat) save(hsdList, file = format(Sys.time(), 'hsdList.%Y-%m-%d.Rdata'))
    hsdList
  }
