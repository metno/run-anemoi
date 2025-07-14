#!/bin/bash

export VIRTUAL_ENV="$(pwd -P)/.venv"
if [ ! -d "$VIRTUAL_ENV" ]; then
    mkdir -p $VIRTUAL_ENV/lib $VIRTUAL_ENV/bin
fi

export PYTHONUSERBASE=$VIRTUAL_ENV
export PATH=$PATH:$VIRTUAL_ENV/bin

# Clone anemoi-core if not already cloned
if [ ! -d anemoi-core ]; then
    echo "Cloning anemoi-core from ecmwf"
    git clone --branch main https://github.com/ecmwf/anemoi-core.git
    cd anemoi-core
    git remote set-url origin git@github.com:ecmwf/anemoi-core.git
    cd ..
fi

# Install training, models, and graphs from anemoi-core
echo "Installing graphs from anemoi-core"
pip install --no-deps -e anemoi-core/graphs

# Clone and install utils if not already cloned
if [ ! -d anemoi-utils ]; then
    echo "Cloning anemoi-utils from ecmwf"
    git clone https://github.com/ecmwf/anemoi-utils.git
    cd anemoi-utils
    cd ..
fi
pip install --no-deps -e anemoi-utils

# Clone and install datasets if not already cloned
if [ ! -d anemoi-datasets ]; then
    echo "Cloning anemoi-datasets from ecmwf"
    git clone https://github.com/ecmwf/anemoi-datasets.git
    cd anemoi-datasets
    git remote set-url origin git@github.com:ecmwf/anemoi-datasets.git
    cd ..
fi
pip install --no-deps -e anemoi-datasets

# Clone and install anemoi-training-downscaling
if [ ! -d anemoi-training-downscaling ]; then
    echo "Cloning anemoi-training-downscaling from ecmwf-lab"
    git clone git@github.com:ecmwf-lab/anemoi-training-downscaling.git
fi
pip install --no-deps -e anemoi-training-downscaling

# Clone and install anemoi-models-downscaling
if [ ! -d anemoi-models-downscaling ]; then
    echo "Cloning anemoi-models-downscaling from ecmwf-lab"
    git clone git@github.com:ecmwf-lab/anemoi-models-downscaling.git
fi
pip install --no-deps -e anemoi-models-downscaling
