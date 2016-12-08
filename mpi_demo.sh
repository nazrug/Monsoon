#!/bin/bash
#SBTACH --job-name="MPI Demo R"
#SBATCH --nodes=2
#SBATCH --tasks-per-node=4
#SBATCH --time=00:10:00
#SBATCH --mem=500M
#SBATCH --output="/home/cd622/mpi_demo.out"

module load openmpi/1.6.5

srun Rscript mpi_example.R
