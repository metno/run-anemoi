CONTAINER=/pfs/lustrep2/scratch/project_465001893/anemoi/containers/containers/anemoi-training-pytorch-2.2.2-rocm-5.6.1-py-3.11.5.sif
singularity exec -B /pfs:/pfs $CONTAINER anemoi-training mlflow login --url https://mlflow.ecmwf.int
