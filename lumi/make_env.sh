#!/bin/bash

cd $(pwd -P)

# Make files executable in the container (might not be needed)
chmod 770 env_setup.sh

PROJECT_DIR=/pfs/lustrep2/scratch/project_465001893/
CONTAINER=$PROJECT_DIR/anemoi/containers/anemoi-training-pytorch-2.3.1-rocm-6.0.3-py-3.11.5.sif

# Clone and pip install anemoi repos from the container
singularity exec -B /pfs:/pfs $CONTAINER $(pwd -P)/env_setup.sh
