#!/bin/bash

set -e  # Exit on any error

ROOT_DIR="$(pwd -P)"
VENV_DIR="$ROOT_DIR/.venv"

echo "Using virtual env at $VENV_DIR"

mkdir -p "$VENV_DIR/bin" "$VENV_DIR/lib"
export PYTHONUSERBASE=$VENV_DIR
export PATH=$VENV_DIR/bin:$PATH

# Helper: add minimal setup.py if needed
add_setup_py_if_missing() {
    local repo_path="$1"
    if [ ! -f "$repo_path/setup.py" ]; then
        echo "Adding minimal setup.py to $repo_path"
        cat <<EOF > "$repo_path/setup.py"
from setuptools import setup
setup()
EOF
    fi
}

# Clone anemoi-core if not present
if [ ! -d "$ROOT_DIR/anemoi-core" ]; then
    echo "Cloning anemoi-core..."
    git clone --branch main https://github.com/ecmwf/anemoi-core.git "$ROOT_DIR/anemoi-core"
    git -C "$ROOT_DIR/anemoi-core" remote set-url origin git@github.com:ecmwf/anemoi-core.git
fi

# Install anemoi-core/graphs
add_setup_py_if_missing "$ROOT_DIR/anemoi-core/graphs"
echo "Installing anemoi-core/graphs..."
pip install --no-deps -e "$ROOT_DIR/anemoi-core/graphs"

# anemoi-utils
if [ ! -d "$ROOT_DIR/anemoi-utils" ]; then
    echo "Cloning anemoi-utils..."
    git clone https://github.com/ecmwf/anemoi-utils.git "$ROOT_DIR/anemoi-utils"
fi
add_setup_py_if_missing "$ROOT_DIR/anemoi-utils"
pip install --no-deps -e "$ROOT_DIR/anemoi-utils"

# anemoi-datasets
if [ ! -d "$ROOT_DIR/anemoi-datasets" ]; then
    echo "Cloning anemoi-datasets..."
    git clone https://github.com/ecmwf/anemoi-datasets.git "$ROOT_DIR/anemoi-datasets"
    git -C "$ROOT_DIR/anemoi-datasets" remote set-url origin git@github.com:ecmwf/anemoi-datasets.git
fi
add_setup_py_if_missing "$ROOT_DIR/anemoi-datasets"
pip install --no-deps -e "$ROOT_DIR/anemoi-datasets"

# anemoi-training-downscaling
if [ ! -d "$ROOT_DIR/anemoi-training-downscaling" ]; then
    echo "Cloning anemoi-training-downscaling..."
    git clone git@github.com:ecmwf-lab/anemoi-training-downscaling.git "$ROOT_DIR/anemoi-training-downscaling"
fi
add_setup_py_if_missing "$ROOT_DIR/anemoi-training-downscaling"
pip install --no-deps -e "$ROOT_DIR/anemoi-training-downscaling"

# anemoi-models-downscaling
if [ ! -d "$ROOT_DIR/anemoi-models-downscaling" ]; then
    echo "Cloning anemoi-models-downscaling..."
    git clone git@github.com:ecmwf-lab/anemoi-models-downscaling.git "$ROOT_DIR/anemoi-models-downscaling"
fi
add_setup_py_if_missing "$ROOT_DIR/anemoi-models-downscaling"
pip install --no-deps -e "$ROOT_DIR/anemoi-models-downscaling"

echo "✅ Environment setup complete."

