SOURCE= #INSERT SOURCE PATH f.ex output/logs/mlflow/
RUNID= # run-id of the run f.ex dca82f0b235542d1bc4e4c8fcdcb71a1



PROJECT_DIR=/pfs/lustrep4/scratch/project_465001313
CONTAINER=$PROJECT_DIR/aifs/container/containers/anemoi-training-pytorch-2.2.2-rocm-5.6.1-py-3.11.5.sif
export VIRTUAL_ENV="$(pwd -P)/.venv"

export PYTHONUSERBASE=$VIRTUAL_ENV
export PATH=$PATH:$VIRTUAL_ENV/bin

# For example: /pfs/lustrep4/scratch/project_465001383/salihiar/Output/logs/mlflow/
export SCRATCH=/pfs/lustrep4/scratch/project_465001383/INSERT_PATH_TO_OUTPUT_FOLDER

PYTHONUSERBASE="/" singularity exec --env PATH=$PATH \
    --env PYTHONUSERBASE=$PYTHONUSERBASE -B /pfs:/pfs \
    $CONTAINER anemoi-training mlflow sync \
    --source $SOURCE \
    --destination https://mlflow.ecmwf.int \
    -a \
    --run-id $RUNID \
    --experiment-name metno \
    --verbose