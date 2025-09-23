#!/bin/bash

export VIRTUAL_ENV="$(pwd -P)/.venv"
if [ ! -d "$VIRTUAL_ENV" ]; then
    mkdir -p $VIRTUAL_ENV/lib $VIRTUAL_ENV/bin
fi

export PYTHONUSERBASE=$VIRTUAL_ENV
export PATH=$PATH:$VIRTUAL_ENV/bin

if [ ! -d anemoi-inference ]; then
    echo "Cloning anemoi-inference (feat/downscaling branch)"
    git clone -b feat/downscaling https://github.com/ecmwf/anemoi-inference.git
    cd anemoi-inference
    git remote set-url origin git@github.com:ecmwf/anemoi-inference.git
    cd ..
fi

pip install --no-deps -e anemoi-inference

# Clone and install anemoi-utils (default branch)
if [ ! -d anemoi-utils ]; then
    echo "Cloning anemoi-utils"
    git clone https://github.com/ecmwf/anemoi-utils.git
    cd anemoi-utils
    git remote set-url origin git@github.com:ecmwf/anemoi-utils.git
    cd ..
fi
pip install --no-deps -e anemoi-utils


# anemoi-transform
if [ ! -d anemoi-transform ]; then
    echo "Cloning anemoi-transform"
    git clone https://github.com/ecmwf/anemoi-transform.git
    cd anemoi-transform
    git remote set-url origin git@github.com:ecmwf/anemoi-transform.git
    cd ..
fi
pip install --no-deps -e anemoi-transform

# Clone and install anemoi-datasets
if [ ! -d anemoi-datasets ]; then
    echo "Cloning anemoi-datasets..."
    git clone https://github.com/ecmwf/anemoi-datasets.git
    cd anemoi-datasets
    git remote set-url origin git@github.com:ecmwf/anemoi-datasets.git
    cd ..
fi
pip install --no-deps -e anemoi-datasets


# Clone and install anemoi-models-downscaling
if [ ! -d anemoi-models-downscaling ]; then
    echo "Cloning anemoi-models-downscaling..."
    git clone git@github.com:ecmwf-lab/anemoi-models-downscaling.git
    cd anemoi-models-downscaling
    git remote set-url origin git@github.com:ecmwf-lab/anemoi-models-downscaling.git
    cd ..
fi
pip install --no-deps -e anemoi-models-downscaling


# Other packages
pip install icecream
