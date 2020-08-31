#!/bin/bash
#SBATCH --job-name="Spse1.4"
#SBATCH --comment="The Stochastic Problem Solving Environment (SPSE)"
#SBATCH --ntasks=100
#SBATCH --array=0-99
#SBATCH --mem=1gb
#SBATCH --output=output_%j.log
#SBATCH --error=error_%j.log

# Arguments
NAME=spse
TAG=1.4
ID="${SLURM_ARRAY_TASK_ID}"

# Run
singularity exec "${NAME}-${TAG}.img" ...
