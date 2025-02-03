#!/bin/bash

export VIRTUAL_ENV="$(pwd -P)/.venv"
if [ ! -d "$VIRTUAL_ENV" ]; then
    mkdir -p $VIRTUAL_ENV/lib $VIRTUAL_ENV/bin
fi

export PYTHONUSERBASE=$VIRTUAL_ENV
export PATH=$PATH:VIRTUAL_ENV/bin

if [ ! -d bris-inference ]; then
    echo "Cloning bris-inference"
    git clone https://github.com/metno/bris-inference.git
    cd bris-inference
    git remote set-url origin git@github.com:metno/bris-inference.git
    cd ..
fi
pip install --user --no-deps -e bris-inference
