#!/bin/bash

cd $(pwd -P)

# Make files executable in the container (might not be needed)
chmod 770 env_setup_ds.sh

PROJECT_DIR=/pfs/lustrep2/scratch/project_465001893
CONTAINER=$PROJECT_DIR/anemoi/containers/containers/aifs-met-pytorch-2.2.0-rocm-5.6.1-py3.9-v2.0-new-correct-anemoi-models-sort-vars.sif

# Clone and pip install anemoi repos from the container
singularity exec -B /pfs:/pfs $CONTAINER $(pwd -P)/env_setup_ds.sh

