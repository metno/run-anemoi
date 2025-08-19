#!/bin/bash

cd $(pwd -P)

# Make files executable in the container (might not be needed)
chmod 770 env_setup_ds.sh

PROJECT_DIR=/pfs/lustrep2/scratch/project_465001893
CONTAINER=$PROJECT_DIR/anemoi/containers/pytorch-2.7.0-rocm-6.2.4-py-3.12.9-v2.0.sif

# Clone and pip install anemoi repos from the container
singularity exec -B /pfs:/pfs $CONTAINER $(pwd -P)/env_setup_ds.sh

