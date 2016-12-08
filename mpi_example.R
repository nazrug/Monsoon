# Load Rmpi and doMPI
library("Rmpi", lib.loc="R/x86_64-redhat-linux-gnu-library/3.3/")
library("doMPI", lib.loc="R/x86_64-redhat-linux-gnu-library/3.3/")
###########################################################
# Setup error handling so that the script might terminate
# in the event of an error - rather than wait indefinitely
###########################################################
options(error = quote(assign(".mpi.err", FALSE, env = .GlobalEnv)))

##################################
# Setup the cluster using Rmpi
#
# Since we started the code via
# "srun", the package will detect
# the available CPUs for use
##################################
cluster <- startMPIcluster()


# Tell foreach to parallelize on the MPI cluster
registerDoMPI(cluster)


# Run a loop in parallel over MPI
# Calulate 1e4 deviates and find the arithmetic mean
telapsed1 <- proc.time()
foreach (i = 1:16) %dopar% {mean(rnorm(1e4))}
telapsed1 <- proc.time() - telapsed1


# Run the same loop in sequence
telapsed2 <- proc.time()
foreach (i = 1:16) %do% {mean(rnorm(1e4))}
telapsed2 <- proc.time() - telapsed2

print(telapsed1)
print(telapsed2)

# Close the cluster
closeCluster(cluster)
mpi.quit

