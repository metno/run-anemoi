#!/bin/bash
#SBATCH --output=/users/%u/%x_%j.out
#SBATCH --error=/users/%u/%x_%j.err
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=8
#SBATCH --account=project_465001383
#SBATCH --partition=dev-g
#SBATCH --gpus-per-node=8
#SBATCH --time=00:30:00
#SBATCH --job-name=breeze_lightning_epsilon
#SBATCH --exclusive


#Change this
CONFIG_NAME=lightning_config.yaml #This file should be located in run-anemoi/lumi

#Should not have to change these
PROJECT_DIR=/scratch/$SLURM_JOB_ACCOUNT
CONTAINER_SCRIPT=$(pwd -P)/run_pytorch.sh
CONFIG_DIR=$(pwd -P)
CONTAINER=$PROJECT_DIR/aifs/container/containers/anemoi-training-pytorch-2.2.2-rocm-5.6.1-py-3.11.5.sif
VENV=$(pwd -P)/.venv
export VIRTUAL_ENV=$VENV

module load LUMI/23.09 partition/G
export SINGULARITYENV_LD_LIBRARY_PATH=/opt/ompi/lib:${EBROOTAWSMINOFIMINRCCL}/lib:/opt/cray/xpmem/2.4.4-2.3_9.1__gff0e1d9.shasta/lib64:${SINGULARITYENV_LD_LIBRARY_PATH}

# MPI + OpenMP bindings: https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/distribution-binding
CPU_BIND="mask_cpu:fe000000000000,fe00000000000000,fe0000,fe000000,fe,fe00,fe00000000,fe0000000000"

# run run-pytorch.sh in singularity container like recommended
# in LUMI doc: https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch
srun --cpu-bind=$CPU_BIND \
    singularity exec -B /pfs:/pfs \
                     -B /var/spool/slurmd \
                     -B /opt/cray \
                     -B /usr/lib64 \
                     -B /usr/lib64/libjansson.so.4 \
        $CONTAINER $CONTAINER_SCRIPT $CONFIG_DIR $CONFIG_NAME

